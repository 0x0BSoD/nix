{pkgs, ...}: {
  programs.ghostty.enable = pkgs.stdenv.isLinux;

  xdg.configFile."ghostty/config".source = ./config;

  home.file.".config/ghostty/ripple_cursor.glsl" = {
    text = ''
      // CONFIGURATION
      const float DURATION = 0.15;               // How long the ripple animates (seconds)
      const float MAX_RADIUS = 0.05;             // Max radius in normalized coords (0.5 = 1/4 screen height)
      const float RING_THICKNESS = 0.02;             // Ring width in normalized coords
      const float CURSOR_WIDTH_CHANGE_THRESHOLD = 0.5; // Triggers ripple if cursor width changes by this fraction
      vec4 COLOR = vec4(0.35, 0.36, 0.44, 1.0); // change to iCurrentCursorColor for your cursor's color
      const float BLUR = 3.0;                    // Blur level in pixels
      const float ANIMATION_START_OFFSET = 0.0;        // Start the ripple slightly progressed (0.0 - 1.0)


      // Easing functions
      float easeOutQuad(float t) {
          return 1.0 - (1.0 - t) * (1.0 - t);
      }
      float easeInOutQuad(float t) {
          return t < 0.5 ? 2.0 * t * t : 1.0 - pow(-2.0 * t + 2.0, 2.0) / 2.0;
      }
      float easeOutCubic(float t) {
          return 1.0 - pow(1.0 - t, 3.0);
      }
      float easeOutQuart(float t) {
          return 1.0 - pow(1.0 - t, 4.0);
      }
      float easeOutQuint(float t) {
          return 1.0 - pow(1.0 - t, 5.0);
      }
      float easeOutExpo(float t) {
          return t == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t);
      }
      float easeOutCirc(float t) {
          return sqrt(1.0 - pow(t - 1.0, 2.0));
      }
      float easeOutSine(float t) {
          return sin((t * 3.1415916) / 2.0);
      }
      float easeOutElastic(float t) {
          const float c4 = (2.0 * 3.1415916) / 3.0;
          return t == 0.0 ? 0.0 : t == 1.0 ? 1.0 : pow(2.0, -10.0 * t) * sin((t * 10.0 - 0.75) * c4) + 1.0;
      }
      float easeOutBounce(float t) {
          const float n1 = 7.5625;
          const float d1 = 2.75;
          if (t < 1.0 / d1) {
              return n1 * t * t;
          } else if (t < 2.0 / d1) {
              return n1 * (t -= 1.5 / d1) * t + 0.75;
          } else if (t < 2.5 / d1) {
              return n1 * (t -= 2.25 / d1) * t + 0.9375;
          } else {
              return n1 * (t -= 2.625 / d1) * t + 0.984375;
          }
      }
      float easeOutBack(float t) {
          const float c1 = 1.70158;
          const float c3 = c1 + 1.0;
          return 1.0 + c3 * pow(t - 1.0, 3.0) + c1 * pow(t - 1.0, 2.0);
      }

      // Pulse fade functions
      float easeOutPulse(float t) {
          return t * (2.0 - t);
      }
      float exponentialDecayPulse(float t) {
          return exp(-3.0 * t) * sin(t * 3.1415916);
      }

      vec2 normalize(vec2 value, float isPosition) {
          return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
      }

      void mainImage(out vec4 fragColor, in vec2 fragCoord){
          #if !defined(WEB)
          fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
          #endif

          // Normalization & setup (-1 to 1 coords)
          vec2 vu = normalize(fragCoord, 1.);
          vec2 offsetFactor = vec2(-.5, 0.5);

          vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
          vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

          vec2 centerCC = currentCursor.xy - (currentCursor.zw * offsetFactor);

          float cellWidth = max(currentCursor.z, previousCursor.z); // width of the 'block' cursor

          // check for significant width change
          float widthChange = abs(currentCursor.z - previousCursor.z);
          float widthThresholdNorm = cellWidth * CURSOR_WIDTH_CHANGE_THRESHOLD;
          float isModeChange = step(widthThresholdNorm, widthChange);


          // ANIMATION
          float rippleProgress = (iTime - iTimeCursorChange) / DURATION + ANIMATION_START_OFFSET;
          // don't clamp yet; we need to know if it's > 1.0 (finished)
           float isAnimating = 1.0 - step(1.0, rippleProgress); // progress < 1.0 ? 1.0: 0.0

           if (isModeChange > 0.0 && isAnimating > 0.0) {
              // Apply easing to progress
              // float easedProgress = rippleProgress;
              // float easedProgress = easeOutQuad(rippleProgress);
              // float easedProgress = easeInOutQuad(rippleProgress);
              // float easedProgress = easeOutCubic(rippleProgress);
              // float easedProgress = easeOutQuart(rippleProgress);
              // float easedProgress = easeOutQuint(rippleProgress);
              // float easedProgress = easeOutExpo(rippleProgress);
              float easedProgress = easeOutCirc(rippleProgress);
              // float easedProgress = easeOutSine(rippleProgress);
              // float easedProgress = easeOutBack(rippleProgress);

              // RIPPLE CALCULATION
              float rippleRadius = easedProgress * MAX_RADIUS;

              // float fade = 1.0; // no fade
              // float fade = 1.0 - easedProgress; // linear fade
              float fade = 1.0 - easeOutPulse(rippleProgress);
              // float fade = 1.0 - exponentialDecayPulse(rippleProgress);

              // Calculate distance from frag to cursor center
              float dist = distance(vu, centerCC);

              float sdfRing = abs(dist - rippleRadius) - RING_THICKNESS * 0.5;

              // Antialias (1-pixel width in normalized coords)
              float antiAliasSize = normalize(vec2(BLUR, BLUR), 0.0).x;
              float ripple = (1.0 - smoothstep(-antiAliasSize, antiAliasSize, sdfRing)) * fade;

              // Apply ripple effect
              fragColor = mix(fragColor, COLOR, ripple * COLOR.a);
          }
          // else: do nothing, keep original fragColor
      }
    '';
  };

  home.file.".config/ghostty/cursor_warp.glsl" = {
    text = ''
      // --- CONFIGURATION ---
      vec4 TRAIL_COLOR = iCurrentCursorColor; // can change to eg: vec4(0.2, 0.6, 1.0, 0.5);
      const float DURATION = 0.2; // total animation time
      const float TRAIL_SIZE = 0.8; // 0.0 = all corners move together. 1.0 = max smear (leading corners jump instantly)
      const float THRESHOLD_MIN_DISTANCE = 1.5; // min distance to show trail (units of cursor height)
      const float BLUR = 1.0; // blur size in pixels (for antialiasing)
      const float TRAIL_THICKNESS = 1.0;  // 1.0 = full cursor height, 0.0 = zero height, >1.0 = funky aah
      const float TRAIL_THICKNESS_X = 0.9;

      const float FADE_ENABLED = 0.0; // 1.0 to enable fade gradient along the trail, 0.0 to disable
      const float FADE_EXPONENT = 5.0; // exponent for fade gradient along the trail

      // --- CONSTANTS for easing functions ---
      const float PI = 3.14159265359;
      const float C1_BACK = 1.70158;
      const float C2_BACK = C1_BACK * 1.525;
      const float C3_BACK = C1_BACK + 1.0;
      const float C4_ELASTIC = (2.0 * PI) / 3.0;
      const float C5_ELASTIC = (2.0 * PI) / 4.5;
      const float SPRING_STIFFNESS = 9.0;
      const float SPRING_DAMPING = 0.9;

      // --- EASING FUNCTIONS ---

      // // Linear
      // float ease(float x) {
      //     return x;
      // }

      // // EaseOutQuad
      // float ease(float x) {
      //     return 1.0 - (1.0 - x) * (1.0 - x);
      // }

      // // EaseOutCubic
      // float ease(float x) {
      //     return 1.0 - pow(1.0 - x, 3.0);
      // }

      // // EaseOutQuart
      // float ease(float x) {
      //     return 1.0 - pow(1.0 - x, 4.0);
      // }

      // // EaseOutQuint
      // float ease(float x) {
      //     return 1.0 - pow(1.0 - x, 5.0);
      // }

      // // EaseOutSine
      // float ease(float x) {
      //     return sin((x * PI) / 2.0);
      // }

      // // EaseOutExpo
      // float ease(float x) {
      //     return x == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * x);
      // }

      // EaseOutCirc
      float ease(float x) {
          return sqrt(1.0 - pow(x - 1.0, 2.0));
      }

      // // EaseOutBack
      // float ease(float x) {
      //     return 1.0 + C3_BACK * pow(x - 1.0, 3.0) + C1_BACK * pow(x - 1.0, 2.0);
      // }

      // // EaseOutElastic
      // float ease(float x) {
      //     return x == 0.0 ? 0.0
      //          : x == 1.0 ? 1.0
      //                     : pow(2.0, -10.0 * x) * sin((x * 10.0 - 0.75) * C4_ELASTIC) + 1.0;
      // }

      // // Parametric Spring
      // float ease(float x) {
      //     x = clamp(x, 0.0, 1.0);
      //     float decay = exp(-SPRING_DAMPING * SPRING_STIFFNESS * x);
      //     float freq = sqrt(SPRING_STIFFNESS * (1.0 - SPRING_DAMPING * SPRING_DAMPING));
      //     float osc = cos(freq * 6.283185 * x) + (SPRING_DAMPING * sqrt(SPRING_STIFFNESS) / freq) * sin(freq * 6.283185 * x);
      //     return 1.0 - decay * osc;
      // }

      float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b)
      {
          vec2 d = abs(p - xy) - b;
          return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
      }

      // Based on Inigo Quilez's 2D distance functions article: https://iquilezles.org/articles/distfunctions2d/
      // Potencially optimized by eliminating conditionals and loops to enhance performance and reduce branching
      float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
          vec2 e = b - a;
          vec2 w = p - a;
          vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
          float segd = dot(p - proj, p - proj);
          d = min(d, segd);

          float c0 = step(0.0, p.y - a.y);
          float c1 = 1.0 - step(0.0, p.y - b.y);
          float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
          float allCond = c0 * c1 * c2;
          float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
          float flip = mix(1.0, -1.0, step(0.5, allCond + noneCond));
          s *= flip;
          return d;
      }

      float getSdfConvexQuad(in vec2 p, in vec2 v1, in vec2 v2, in vec2 v3, in vec2 v4) {
          float s = 1.0;
          float d = dot(p - v1, p - v1);

          d = seg(p, v1, v2, s, d);
          d = seg(p, v2, v3, s, d);
          d = seg(p, v3, v4, s, d);
          d = seg(p, v4, v1, s, d);

          return s * sqrt(d);
      }

      vec2 normalize(vec2 value, float isPosition) {
          return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
      }

      float antialising(float distance, float blurAmount) {
        return 1. - smoothstep(0., normalize(vec2(blurAmount, blurAmount), 0.).x, distance);
      }

      // Determines animation duration based on a corner's alignment with the move direction(dot product)
      // dot_val will be in [-2, 2]
      // > 0.5 (1 or 2) = Leading
      // > -0.5 (0)     = Side
      // <= -0.5 (-1 or -2) = Trailing
      float getDurationFromDot(float dot_val, float DURATION_LEAD, float DURATION_SIDE, float DURATION_TRAIL) {
          float isLead = step(0.5, dot_val);
          float isSide = step(-0.5, dot_val) * (1.0 - isLead);

          // Start with trailing duration
          float duration = mix(DURATION_TRAIL, DURATION_SIDE, isSide);
          // Mix in leading duration
          duration = mix(duration, DURATION_LEAD, isLead);
          return duration;
      }

      void mainImage(out vec4 fragColor, in vec2 fragCoord){
          #if !defined(WEB)
          fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
          #endif

          // normalization & setup(-1, 1 coords)
          vec2 vu = normalize(fragCoord, 1.);
          vec2 offsetFactor = vec2(-.5, 0.5);

          vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
          vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

          vec2 centerCC = currentCursor.xy - (currentCursor.zw * offsetFactor);
          vec2 halfSizeCC = currentCursor.zw * 0.5;
          vec2 centerCP = previousCursor.xy - (previousCursor.zw * offsetFactor);
          vec2 halfSizeCP = previousCursor.zw * 0.5;

          float sdfCurrentCursor = getSdfRectangle(vu, centerCC, halfSizeCC);

          float lineLength = distance(centerCC, centerCP);
          float minDist = currentCursor.w * THRESHOLD_MIN_DISTANCE;

          vec4 newColor = vec4(fragColor);

          float baseProgress = iTime - iTimeCursorChange;

          if (lineLength > minDist && baseProgress < DURATION - 0.001) {
              // defining corners of cursors

              // Y (Height) with TRAIL_THICKNESS
              float cc_half_height = currentCursor.w * 0.5;
              float cc_center_y = currentCursor.y - cc_half_height;
              float cc_new_half_height = cc_half_height * TRAIL_THICKNESS;
              float cc_new_top_y = cc_center_y + cc_new_half_height;
              float cc_new_bottom_y = cc_center_y - cc_new_half_height;

              // X (Width) with TRAIL_THICKNESS
              float cc_half_width = currentCursor.z * 0.5;
              float cc_center_x = currentCursor.x + cc_half_width;
              float cc_new_half_width = cc_half_width * TRAIL_THICKNESS_X;
              float cc_new_left_x = cc_center_x - cc_new_half_width;
              float cc_new_right_x = cc_center_x + cc_new_half_width;

              vec2 cc_tl = vec2(cc_new_left_x, cc_new_top_y);
              vec2 cc_tr = vec2(cc_new_right_x, cc_new_top_y);
              vec2 cc_bl = vec2(cc_new_left_x, cc_new_bottom_y);
              vec2 cc_br = vec2(cc_new_right_x, cc_new_bottom_y);

              // same thing for previous cursor
              float cp_half_height = previousCursor.w * 0.5;
              float cp_center_y = previousCursor.y - cp_half_height;
              float cp_new_half_height = cp_half_height * TRAIL_THICKNESS;
              float cp_new_top_y = cp_center_y + cp_new_half_height;
              float cp_new_bottom_y = cp_center_y - cp_new_half_height;

              float cp_half_width = previousCursor.z * 0.5;
              float cp_center_x = previousCursor.x + cp_half_width;
              float cp_new_half_width = cp_half_width * TRAIL_THICKNESS_X;
              float cp_new_left_x = cp_center_x - cp_new_half_width;
              float cp_new_right_x = cp_center_x + cp_new_half_width;

              vec2 cp_tl = vec2(cp_new_left_x, cp_new_top_y);
              vec2 cp_tr = vec2(cp_new_right_x, cp_new_top_y);
              vec2 cp_bl = vec2(cp_new_left_x, cp_new_bottom_y);
              vec2 cp_br = vec2(cp_new_right_x, cp_new_bottom_y);

              // calculating durations for every corner
              const float DURATION_TRAIL = DURATION;
              const float DURATION_LEAD = DURATION * (1.0 - TRAIL_SIZE);
              const float DURATION_SIDE = (DURATION_LEAD + DURATION_TRAIL) / 2.0;

              vec2 moveVec = centerCC - centerCP;
              vec2 s = sign(moveVec);

              // dot products for each corner, determining alignment with movement direction
              float dot_tl = dot(vec2(-1., 1.), s);
              float dot_tr = dot(vec2( 1., 1.), s);
              float dot_bl = dot(vec2(-1.,-1.), s);
              float dot_br = dot(vec2( 1.,-1.), s);

              // assign durations based on dot products
              float dur_tl = getDurationFromDot(dot_tl, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);
              float dur_tr = getDurationFromDot(dot_tr, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);
              float dur_bl = getDurationFromDot(dot_bl, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);
              float dur_br = getDurationFromDot(dot_br, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);

              // check direction of horizontal movement
              float isMovingRight = step(0.5, s.x);
              float isMovingLeft  = step(0.5, -s.x);

              // calculate vertical-rail durations
              float dot_right_edge = (dot_tr + dot_br) * 0.5;
              float dur_right_rail = getDurationFromDot(dot_right_edge, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);

              float dot_left_edge = (dot_tl + dot_bl) * 0.5;
              float dur_left_rail = getDurationFromDot(dot_left_edge, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);

              float final_dur_tl = mix(dur_tl, dur_left_rail, isMovingLeft);
              float final_dur_bl = mix(dur_bl, dur_left_rail, isMovingLeft);

              float final_dur_tr = mix(dur_tr, dur_right_rail, isMovingRight);
              float final_dur_br = mix(dur_br, dur_right_rail, isMovingRight);

              // calculate progress for each corner based on the duration and time since cursor change
              float prog_tl = ease(clamp(baseProgress / final_dur_tl, 0.0, 1.0));
              float prog_tr = ease(clamp(baseProgress / final_dur_tr, 0.0, 1.0));
              float prog_bl = ease(clamp(baseProgress / final_dur_bl, 0.0, 1.0));
              float prog_br = ease(clamp(baseProgress / final_dur_br, 0.0, 1.0));

              // get the trial corner positions based on progress
              vec2 v_tl = mix(cp_tl, cc_tl, prog_tl);
              vec2 v_tr = mix(cp_tr, cc_tr, prog_tr);
              vec2 v_br = mix(cp_br, cc_br, prog_br);
              vec2 v_bl = mix(cp_bl, cc_bl, prog_bl);

              // DRAWING THE TRAIL
              float sdfTrail = getSdfConvexQuad(vu, v_tl, v_tr, v_br, v_bl);

              // --- FADE GRADIENT CALCULATION ---
              vec2 fragVec = vu - centerCP;

              // project fragment onto movement vector, normalize to [0, 1]
              // 0.0 at tail, 1.0 at head
              // tiny epsilon to avoid division by zero if moveVec is (0,0)
              float fadeProgress = clamp(dot(fragVec, moveVec) / (dot(moveVec, moveVec) + 1e-6), 0.0, 1.0);

              vec4 trail = TRAIL_COLOR;

              float effectiveBlur = BLUR;
              if (BLUR < 2.5) {
                // no antialising on horizontal/vertical movement, fixes 'pulse' like thing on end cursor
                float isDiagonal = abs(s.x) * abs(s.y); // 1.0 if diagonal, 0.0 if H/V
                float effectiveBlur = mix(0.0, BLUR, isDiagonal);
              }
              float shapeAlpha = antialising(sdfTrail, effectiveBlur); // shape mask

              if (FADE_ENABLED > 0.5) {
                  // apply fade gradient along the trail
                  // float fadeStart = 0.2;
                  // float easedProgress = smoothstep(fadeStart, 1.0, fadeProgress);
                  // easedProgress = pow(2.0, 10.0 * (fadeProgress - 1.0));
                  float easedProgress = pow(fadeProgress, FADE_EXPONENT);
                  trail.a *= easedProgress;
              }

              float finalAlpha = trail.a * shapeAlpha;

              // newColor.a to preserve the background alpha.
              newColor = mix(newColor, vec4(trail.rgb, newColor.a), finalAlpha);

              // punch hole on the trail, so current cursor is drawn on top
              newColor = mix(newColor, fragColor, step(sdfCurrentCursor, 0.));

          }

          fragColor = newColor;
      }
    '';
  };

  home.file.".config/ghostty/cubes.glsl" = {
    text = ''
      // credits: https://github.com/rymdlego

      const float speed = 0.2;
      const float cube_size = 1.0;
      const float cube_brightness = 1.0;
      const float cube_rotation_speed = 2.8;
      const float camera_rotation_speed = 0.1;



      mat3 rotationMatrix(vec3 m,float a) {
          m = normalize(m);
          float c = cos(a),s=sin(a);
          return mat3(c+(1.-c)*m.x*m.x,
              (1.-c)*m.x*m.y-s*m.z,
              (1.-c)*m.x*m.z+s*m.y,
              (1.-c)*m.x*m.y+s*m.z,
              c+(1.-c)*m.y*m.y,
              (1.-c)*m.y*m.z-s*m.x,
              (1.-c)*m.x*m.z-s*m.y,
              (1.-c)*m.y*m.z+s*m.x,
              c+(1.-c)*m.z*m.z);
      }

      float sphere(vec3 pos, float radius)
      {
          return length(pos) - radius;
      }

      float box(vec3 pos, vec3 size)
      {
          float t = iTime;
          pos = pos * 0.9 * rotationMatrix(vec3(sin(t/4.0*speed)*10.,cos(t/4.0*speed)*12.,2.7), t*2.4/4.0*speed*cube_rotation_speed);
          return length(max(abs(pos) - size, 0.0));
      }


      float distfunc(vec3 pos)
      {
          float t = iTime;

          float size = 0.45 + 0.25*abs(16.0*sin(t*speed/4.0));
          // float size = 2.3 + 1.8*tan((t-5.4)*6.549);
          size = cube_size * 0.16 * clamp(size, 2.0, 4.0);

          //pos = pos * rotationMatrix(vec3(0.,-3.,0.7), 3.3 * mod(t/30.0, 4.0));
          vec3 q = mod(pos, 5.0) - 2.5;
          float obj1 = box(q, vec3(size));
          return obj1;
      }

      void mainImage( out vec4 fragColor, in vec2 fragCoord )
      {
          float t = iTime;
          vec2 screenPos = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
          screenPos.x *= iResolution.x / iResolution.y;
          vec3 cameraOrigin = vec3(t*1.0*speed, 0.0, 0.0);
          // vec3 cameraOrigin = vec3(t*1.8*speed, 3.0+t*0.02*speed, 0.0);
          vec3 cameraTarget = vec3(t*100., 0.0, 0.0);
          cameraTarget = vec3(t*20.0,0.0,0.0) * rotationMatrix(vec3(0.0,0.0,1.0), t*speed*camera_rotation_speed);

          vec3 upDirection = vec3(0.5, 1.0, 0.6);

          vec3 cameraDir = normalize(cameraTarget - cameraOrigin);
          vec3 cameraRight = normalize(cross(upDirection, cameraOrigin));
          vec3 cameraUp = cross(cameraDir, cameraRight);

          vec3 rayDir = normalize(cameraRight * screenPos.x + cameraUp * screenPos.y + cameraDir);

          const int MAX_ITER = 64;
          const float MAX_DIST = 48.0;
          const float EPSILON = 0.001;

          float totalDist = 0.0;
          vec3 pos = cameraOrigin;
          float dist = EPSILON;

          for (int i = 0; i < MAX_ITER; i++)
          {
              if (dist < EPSILON || totalDist > MAX_DIST)
                  break;
              dist = distfunc(pos);
              totalDist += dist;
              pos += dist*rayDir;
          }

          vec4 cubes;

          if (dist < EPSILON)
          {
              // Lighting Code
              vec2 eps = vec2(0.0, EPSILON);
              vec3 normal = normalize(vec3(
                  distfunc(pos + eps.yxx) - distfunc(pos - eps.yxx),
                  distfunc(pos + eps.xyx) - distfunc(pos - eps.xyx),
                  distfunc(pos + eps.xxy) - distfunc(pos - eps.xxy)));
              float diffuse = max(0., dot(-rayDir, normal));
              float specular = pow(diffuse, 32.0);
              vec3 color = vec3(diffuse + specular);
              vec3 cubeColor = vec3(abs(screenPos),0.5+0.5*sin(t*2.0))*0.8;
              cubeColor = mix(cubeColor.rgb, vec3(0.0,0.0,0.0), 1.0);
              color += cubeColor;
              cubes = vec4(color, 1.0) * vec4(1.0 - (totalDist/MAX_DIST));
              cubes = vec4(cubes.rgb*0.02*cube_brightness, 0.1);
          }
          else {
              cubes = vec4(0.0);
          }

          vec2 uv = fragCoord/iResolution.xy;
          vec4 terminalColor = texture(iChannel0, uv);
          vec3 blendedColor = terminalColor.rgb + cubes.rgb;
          fragColor = vec4(blendedColor, terminalColor.a);
      }
    '';
    executable = true;
  };

  home.file.".config/ghostty/startup.sh" = {
    text = ''
      #!/usr/bin/env bash
      SESSION_NAME="ghostty"
      if tmux has-session -t $SESSION_NAME 2>/dev/null; then
        tmux attach-session -t $SESSION_NAME
      else
        tmux new-session -s $SESSION_NAME -d
        tmux attach-session -t $SESSION_NAME
      fi
    '';
    executable = true;
  };
}
