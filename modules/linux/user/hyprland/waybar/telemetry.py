"""Streaming RunCat animation and optional Linux hwmon readings for Waybar."""

import html
import json
from pathlib import Path
import sys
import time


def cpu_sample(path=Path("/proc/stat")):
    # Guest time is already included in user/nice; do not count it twice.
    ticks = [int(value) for value in path.read_text().splitlines()[0].split()[1:9]]
    return sum(ticks), ticks[3] + ticks[4]


def cpu_usage(previous, current):
    total = current[0] - previous[0]
    idle = current[1] - previous[1]
    return max(0.0, min(100.0, 100 * (total - idle) / total)) if total > 0 else 0.0


def frame_delay(usage):
    # Five glyphs per stride: 0.6 strides/s at idle, 4 strides/s at full load.
    return 1 / (3 + 17 * usage / 100)


def emit(payload):
    print(json.dumps(payload, ensure_ascii=False), flush=True)


def runcat():
    previous = cpu_sample()
    next_sample = time.monotonic() + 1
    usage = 0.0
    frame = 0
    while True:
        now = time.monotonic()
        if now >= next_sample:
            current = cpu_sample()
            usage = cpu_usage(previous, current)
            previous = current
            next_sample = now + 1
        emit({
            "text": chr(0xE900 + frame),
            "tooltip": f"CPU {usage:.0f}% — the busier the CPU, the faster the cat",
            "class": "high" if usage >= 80 else "medium" if usage >= 40 else "low",
            "percentage": round(usage),
        })
        frame = (frame + 1) % 5
        time.sleep(frame_delay(usage))


def read_text(path):
    try:
        return path.read_text().strip()
    except OSError:
        return ""


def sensors(root=Path("/sys/class/hwmon")):
    temperatures = []
    fans = []
    for device in sorted(root.glob("hwmon*")):
        name = read_text(device / "name") or device.name
        for kind, readings in (("temp", temperatures), ("fan", fans)):
            for path in sorted(device.glob(f"{kind}*_input")):
                try:
                    value = int(path.read_text().strip())
                except (OSError, ValueError):
                    continue
                invalid_temp = kind == "temp" and not -20000 <= value <= 150000
                invalid_fan = kind == "fan" and value < 0
                if invalid_temp or invalid_fan:
                    continue
                label = read_text(path.with_name(path.name.replace("_input", "_label")))
                readings.append((name, label or path.name.removesuffix("_input"), value))

    parts = []
    # Discover by driver name on every poll: hwmon indices can change at boot.
    cpu = [v for n, label, v in temperatures if n in ("coretemp", "k10temp", "zenpower")]
    ssd = [v for n, label, v in temperatures if n == "nvme"]
    if cpu:
        parts.append(f"CPU {max(cpu) / 1000:.0f}°C")
    if ssd:
        parts.append(f"SSD {max(ssd) / 1000:.0f}°C")
    if not parts and temperatures:
        parts.append(f"{max(v for _, _, v in temperatures) / 1000:.0f}°C")
    if fans:
        parts.append(f"󰈐 {max(v for _, _, v in fans)} RPM")

    tooltip = [f"{n} / {label}: {v / 1000:.1f}°C" for n, label, v in temperatures]
    tooltip += [f"{n} / {label}: {v} RPM" for n, label, v in fans]
    return {
        "text": "  ".join(parts),
        "tooltip": html.escape("\n".join(tooltip)),
        "class": "critical" if cpu and max(cpu) >= 90000 else "normal",
    }


if __name__ == "__main__":
    try:
        if sys.argv[1] == "runcat":
            runcat()
        elif sys.argv[1] == "sensors":
            emit(sensors())
    except BrokenPipeError:
        pass
