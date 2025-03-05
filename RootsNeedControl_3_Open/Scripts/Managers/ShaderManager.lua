ShaderManager = {}

currentNormalShader = love.graphics.newShader(
[[
    extern ArrayImage MainTex1;

    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) 
    {
        vec4 pixel = Texel(texture, texture_coords);
        return pixel * color;
    }
]])

currentGrayedShader = love.graphics.newShader(
[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) 
    {
      vec4 texcolor = Texel(texture, texture_coords);

      float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));
      
      vec3 finalcolor = vec3(intensity);
      return vec4(finalcolor, texcolor.a);
    }
]]
)

currentVBShader = love.graphics.newShader(
[[
    vec3 color1 = vec3(6.0/255.0, 0.0, 0.0);
    vec3 color2 = vec3(52.0/255.0, 0.0, 0.0);
    vec3 color3 = vec3(111.0/255.0, 0.0, 0.0);
    vec3 color4 = vec3(183.0/255.0, 0.0, 0.0);
    vec3 color5 = vec3(255.0/255.0, 0.0, 0.0);
    
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) 
    {
        vec4 texcolor = Texel(texture, texture_coords);

        float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));

        vec3 finalcolor = mix(color1, color2, smoothstep(0.0, 0.25, intensity));
        finalcolor = mix(finalcolor, color3, smoothstep(0.25, 0.50, intensity));
        finalcolor = mix(finalcolor, color4, smoothstep(0.50, 0.75, intensity));
        finalcolor = mix(finalcolor, color5, smoothstep(0.75, 1.0, intensity));

        return vec4(finalcolor, texcolor.a);
    }  
]])

currentGBShader = love.graphics.newShader([[

    vec3 color1 = vec3(15.0/255.0, 56.0/255.0, 15.0/255.0);
    vec3 color2 = vec3(48.0/255.0, 98.0/255.0, 48.0/255.0);
    vec3 color3 = vec3(139.0/255.0, 172.0/255.0, 15.0/255.0);
    vec3 color4 = vec3(155.0/255.0, 188.0/255.0, 15.0/255.0);

    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) 
    {
        vec4 texcolor = Texel(texture, texture_coords);
        
        float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));
        
        vec3 finalcolor = mix(color1, color2, smoothstep(0.0, 0.33, intensity));
        finalcolor = mix(finalcolor, color3, smoothstep(0.33, 0.67, intensity));
        finalcolor = mix(finalcolor, color4, smoothstep(0.67, 1.0, intensity));
        
        return vec4(finalcolor, texcolor.a);
    }
]])

currentPico8Shader = love.graphics.newShader([[

    vec3 color0 = vec3(0.0, 0.0, 0.0);
    vec3 color1 = vec3(29.0/255.0, 43.0/255.0, 83.0/255.0);
    vec3 color2 = vec3(126.0/255.0, 37.0/255.0, 83.0/255.0);
    vec3 color3 = vec3(0.0, 135.0/255.0, 81.0/255.0);
    vec3 color4 = vec3(171.0/255.0, 82.0/255.0, 54.0/255.0);
    vec3 color5 = vec3(95.0/255.0, 87.0/255.0, 79.0/255.0);
    vec3 color6 = vec3(194.0/255.0, 195.0/255.0, 199.0/255.0);
    vec3 color7 = vec3(255.0/255.0, 241.0/255.0, 232.0/255.0);
    vec3 color8 = vec3(255.0/255.0, 0.0, 77.0/255.0);
    vec3 color9 = vec3(255.0/255.0, 163.0/255.0, 0.0);
    vec3 color10 = vec3(255.0/255.0, 240.0/255.0, 36.0/255.0);
    vec3 color11 = vec3(0.0, 231.0/255.0, 86.0/255.0);
    vec3 color12 = vec3(41.0/255.0, 173.0/255.0, 255.0/255.0);
    vec3 color13 = vec3(131.0/255.0, 118.0/255.0, 156.0/255.0);
    vec3 color14 = vec3(255.0/255.0, 119.0/255.0, 168.0/255.0);
    vec3 color15 = vec3(255.0/255.0, 204.0/255.0, 170.0/255.0);


    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) 
    {
        vec4 texcolor = Texel(texture, texture_coords);
        float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));
    

        vec3 finalcolor = mix(color0, color1, smoothstep(0.0, 0.0625, intensity));

        finalcolor = mix(finalcolor, color2, smoothstep(0.0625, 0.125, intensity));
        finalcolor = mix(finalcolor, color3, smoothstep(0.125, 0.1875, intensity));
        finalcolor = mix(finalcolor, color4, smoothstep(0.1875, 0.25, intensity));
        finalcolor = mix(finalcolor, color5, smoothstep(0.25, 0.3125, intensity));
        finalcolor = mix(finalcolor, color6, smoothstep(0.3125, 0.375, intensity));
        finalcolor = mix(finalcolor, color7, smoothstep(0.375, 0.4375, intensity));
        finalcolor = mix(finalcolor, color8, smoothstep(0.4375, 0.5, intensity));
        finalcolor = mix(finalcolor, color9, smoothstep(0.5, 0.5625, intensity));
        finalcolor = mix(finalcolor, color10, smoothstep(0.5625, 0.625, intensity));
        finalcolor = mix(finalcolor, color11, smoothstep(0.625, 0.6875, intensity));
        finalcolor = mix(finalcolor, color12, smoothstep(0.6875, 0.75, intensity));
        finalcolor = mix(finalcolor, color13, smoothstep(0.75, 0.8125, intensity));
        finalcolor = mix(finalcolor, color14, smoothstep(0.8125, 0.875, intensity));
        finalcolor = mix(finalcolor, color15, smoothstep(0.875, 1.0, intensity));
    
        return vec4(finalcolor, texcolor.a);
    }

]])

currentPinkShader = love.graphics.newShader(
[[
    vec3 color0 = vec3(0.953, 0.906, 0.918);
    vec3 color1 = vec3(0.953, 0.506, 0.569);
    vec3 color2 = vec3(0.996, 0.820, 0.827);
    vec3 color3 = vec3(0.988, 0.545, 0.624);
    vec3 color4 = vec3(0.996, 0.722, 0.761);
        
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) 
    {
        vec4 texcolor = Texel(texture, texture_coords);
            
        float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));
            
        vec3 finalcolor = mix(color0, color1, smoothstep(0.0, 0.25, intensity));
        finalcolor = mix(finalcolor, color2, smoothstep(0.25, 0.5, intensity));
        finalcolor = mix(finalcolor, color3, smoothstep(0.5, 0.75, intensity));
        finalcolor = mix(finalcolor, color4, smoothstep(0.75, 1.0, intensity));
            
        return vec4(finalcolor, texcolor.a);
    }
]]
)

currentBananaShader = love.graphics.newShader(
[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) 
    {
        vec4 texcolor = Texel(texture, texture_coords);
        float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));
        
        vec3 color1 = vec3(1.0, 0.7, 0.0); // #ffb400
        vec3 color2 = vec3(1.0, 0.76, 0.0); // #ffc100
        vec3 color3 = vec3(1.0, 0.86, 0.0); // #ffdb00
        vec3 color4 = vec3(1.0, 0.91, 0.0); // #ffe700
        vec3 color5 = vec3(0.94, 1.0, 0.0); // #f0ff00
        
        vec3 finalcolor = mix(color1, color2, smoothstep(0.0, 0.25, intensity));
        finalcolor = mix(finalcolor, color3, smoothstep(0.25, 0.50, intensity));
        finalcolor = mix(finalcolor, color4, smoothstep(0.50, 0.75, intensity));
        finalcolor = mix(finalcolor, color5, smoothstep(0.75, 1.0, intensity));
        
        return vec4(finalcolor, texcolor.a);
    }    
]]
)

currentSeaShader = love.graphics.newShader(
[[
    vec3 colors[5] = vec3[5](
        vec3(254.0/255.0, 192.0/255.0, 81.0/255.0), // #FEC051
        vec3(255.0/255.0, 136.0/255.0, 102.0/255.0), // #FF8866
        vec3(253.0/255.0, 96.0/255.0, 81.0/255.0), // #FD6051
        vec3(57.0/255.0, 32.0/255.0, 51.0/255.0), // #392033
        vec3(255.0/255.0, 229.0/255.0, 119.0/255.0) // #FFE577
    );
    
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 texcolor = Texel(texture, texture_coords);
    
        float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));
    
        vec3 finalcolor = mix(colors[0], colors[1], smoothstep(0.0, 0.25, intensity));
        finalcolor = mix(finalcolor, colors[2], smoothstep(0.25, 0.50, intensity));
        finalcolor = mix(finalcolor, colors[3], smoothstep(0.50, 0.75, intensity));
        finalcolor = mix(finalcolor, colors[4], smoothstep(0.75, 1.0, intensity));
    
        return vec4(finalcolor, texcolor.a);
    }    
]]
)

currentBreakGold = love.graphics.newShader(
[[
    extern number time;

    const vec2 crt_resolution = vec2(320, 240);

    const float scanline_freq = 0.1;
    const float scanline_thickness = 0.5;

    const vec3 mask = vec3(1.0, 0.8, 0.2);
    const float mask_weight = 1.2;

    const vec3 vignette_color = vec3(1.0, 0.9, 0.6);
    const float vignette_size = 1.2;

    const vec2 chromatic_aberration = vec2(0.005, 0.005);

    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 texcolor = Texel(texture, texture_coords);
        
        vec2 screen_pos = vec2(texture_coords.x * crt_resolution.x, texture_coords.y * crt_resolution.y);
        
        float scanline = abs(sin(screen_pos.y * scanline_freq));
        
        float pixel_pos = mod(screen_pos.x, 2.0);
        
        vec2 aberration_displacement = vec2(pixel_pos * chromatic_aberration.x, 0.0);
        
        vec4 red_color = Texel(texture, texture_coords + aberration_displacement);
        vec4 green_color = texcolor;
        vec4 blue_color = Texel(texture, texture_coords - aberration_displacement);
        
        float color_mask = dot(texcolor.rgb, mask) * mask_weight;
        
        vec2 vignette_pos = vec2(0.5) - screen_pos / crt_resolution;
        float vignette = pow(length(vignette_pos) / vignette_size, 2.0);
        vec3 final_color = mix(vignette_color, vec3(1.0), vignette) * texcolor.rgb;
        
        final_color = mix(final_color, vec3(scanline), scanline_thickness);
        final_color.r = mix(red_color.r, final_color.r, color_mask);
        final_color.g = mix(green_color.g, final_color.g, color_mask);
        final_color.b = mix(blue_color.b, final_color.b, color_mask);
        
        return vec4(final_color, texcolor.a);
    }
]]
)

currentModernGold = love.graphics.newShader(
[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 gradient_color;

        vec4 start_color = vec4(0.96, 0.76, 0.28, 1.0); // 시작 색상 (금색)
        vec4 end_color = vec4(0.67, 0.49, 0.14, 1.0); // 끝 색상 (짙은 갈색)

        gradient_color = mix(start_color, end_color, texture_coords.y);

        vec4 texcolor = texture2D(texture, texture_coords);
        return texcolor * gradient_color * color;
    }
]]
)

currentFinlandPhoneColor = love.graphics.newShader(
[[
    vec3 colors[2] = vec3[2](
        vec3(67.0/255.0, 82.0/255.0, 61.0/255.0), // #43523d
        vec3(199.0/255.0, 240.0/255.0, 216.0/255.0) // #c7f0d8
    );
    
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 texcolor = Texel(texture, texture_coords);
    
        float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));
    
        vec3 finalcolor = mix(colors[0], colors[1], intensity);
    
        return vec4(finalcolor, texcolor.a);
    }
    
]]
)

kawaiancolor = love.graphics.newShader(
[[
    vec3 colors[5] = vec3[5](
        vec3(1.0, 0.8706, 0.949), // #ffdef2
        vec3(0.949, 0.8863, 1.0), // #f2e2ff
        vec3(0.8863, 0.9333, 1.0), // #e2eeff
        vec3(0.8667, 1.0, 0.9882), // #ddfffc
        vec3(1.0, 1.0, 0.8902) // #ffffe3
    );
    
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 texcolor = Texel(texture, texture_coords);
    
        float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));
    
        vec3 finalcolor;
        if (intensity < 0.2) {
            finalcolor = mix(colors[0], colors[1], intensity*5.0);
        } else if (intensity < 0.4) {
            finalcolor = mix(colors[1], colors[2], (intensity-0.2)*5.0);
        } else if (intensity < 0.6) {
            finalcolor = mix(colors[2], colors[3], (intensity-0.4)*5.0);
        } else if (intensity < 0.8) {
            finalcolor = mix(colors[3], colors[4], (intensity-0.6)*5.0);
        } else {
            finalcolor = colors[4];
        }
    
        return vec4(finalcolor, texcolor.a);
    }

]]
)

halfRetro = love.graphics.newShader(
[[
    vec3 colors[6] = vec3[6](
        vec3(32.0/255.0, 13.0/255.0, 58.0/255.0), // #200D3A
        vec3(41.0/255.0, 38.0/255.0, 81.0/255.0), // #292651
        vec3(46.0/255.0, 71.0/255.0, 112.0/255.0), // #2E4770
        vec3(206.0/255.0, 94.0/255.0, 130.0/255.0), // #CE5E82
        vec3(236.0/255.0, 160.0/255.0, 137.0/255.0), // #ECA089
        vec3(236.0/255.0, 198.0/255.0, 162.0/255.0) // #ECC6A2
    );
    
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 texcolor = Texel(texture, texture_coords);
    
        float intensity = dot(texcolor.rgb, vec3(0.299, 0.587, 0.114));
    
        vec3 finalcolor = mix(colors[0], colors[1], intensity);
    
        if (intensity > 0.5) {
            finalcolor = mix(finalcolor, colors[2], (intensity - 0.5) * 2.0);
        }
    
        if (intensity > 0.6) {
            finalcolor = mix(finalcolor, colors[3], (intensity - 0.6) * 2.5);
        }
    
        if (intensity > 0.7) {
            finalcolor = mix(finalcolor, colors[4], (intensity - 0.7) * 5.0);
        }
    
        if (intensity > 0.8) {
            finalcolor = mix(finalcolor, colors[5], (intensity - 0.8) * 10.0);
        }
    
        return vec4(finalcolor, texcolor.a);
    }    
]]
)

rainbowAround = love.graphics.newShader(
[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 gradient_color;

        vec4 rainbow_colors[7] = vec4[](
            vec4(1.0, 0.0, 0.0, 1.0),     // 빨간색
            vec4(1.0, 0.5, 0.0, 1.0),     // 주황색
            vec4(1.0, 1.0, 0.0, 1.0),     // 노란색
            vec4(0.0, 1.0, 0.0, 1.0),     // 초록색
            vec4(0.0, 0.0, 1.0, 1.0),     // 파란색
            vec4(0.5, 0.0, 1.0, 1.0),     // 남색
            vec4(1.0, 0.0, 1.0, 1.0)      // 보라색
        );

        float rainbow_range = 1.0 / 6.0; 
        float current_range = floor(texture_coords.x / rainbow_range); 
        float percent = (texture_coords.x - current_range * rainbow_range) / rainbow_range; 
        gradient_color = mix(rainbow_colors[int(current_range)], rainbow_colors[int(current_range) + 1], percent);

        vec4 texcolor = texture2D(texture, texture_coords);
        return texcolor * gradient_color * color;
    }
]]
)

darkaqua = love.graphics.newShader(
[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 gradient_color = mix(vec4(0.396, 0.773, 0.871, 1.0), vec4(0.239, 0.125, 0.412, 1.0), texture_coords.y);

        vec4 texcolor = texture2D(texture, texture_coords);
        return texcolor * gradient_color * color;
    }
]]
)

whatisworld = love.graphics.newShader(
[[
    extern float time;

    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec2 uv = texture_coords.xy;
        uv += 0.01 * sin(vec2(uv.y, uv.x) * 100.0 + time * 10.0);
        uv -= 0.01 * sin(vec2(uv.y, uv.x) * 100.0 - time * 10.0);
        
        vec4 texcolor = Texel(texture, uv);
        
        return texcolor;
    }
]]
)

nightneon = love.graphics.newShader(
[[
    //BlackBulletIV + Gradient Shader
    extern vec2 size = vec2(20,20);
    extern int samples = 1;
    extern float quality = .15;
    extern number strength = 2;
    
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 source = Texel(texture, texture_coords);
        vec4 sum = vec4(0);
        int diff = (samples - 1) / 2;
        vec2 sizeFactor = vec2(1) / size * quality;
    
        for (int x = -diff; x <= diff; x++)
        {
            for (int y = -diff; y <= diff; y++)
            {
                vec2 offset = vec2(x, y) * sizeFactor;
                sum += Texel(texture, texture_coords + offset);
            }
        }
    
        vec4 punkcolor[2] = vec4[](
            vec4(0.5, 0.0, 0.5, 1.0),
            vec4(0.0, 0.5, 0.5, 1.0)
        );
    
        float punk_range = 1.0 ; 
        float current_range = floor(texture_coords.x / punk_range); 
        float percent = (texture_coords.x - current_range * punk_range) / punk_range; 
        vec4 gradient_color = mix(punkcolor[int(current_range)], punkcolor[int(current_range) + 1], percent);
    
        return ((sum / (samples * samples)) + source) * gradient_color * color * strength;
    }
    
]]
)

function ShaderManager:new()
    local current_Table = 
    {
        states_Shader = 
        {
            "default",
            "old grayed",
            "red black world",
            "greenlight native",
            "pico8 like boy",
            "pink roots boy",
            "banananian skin",
            "end of daejeon night",
            "goldern break",
            "modern gold",
            "finland mobile color",
            "kawaian color",
            "half retro",
            "rainbow around",
            "dark aqua",
            "what is this world?",
            "nightpunk in daejeon"
        },

        current_Shader = "default",
        current_Shader_idx = 1
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function ShaderManager:Init()
    self.current_Shader = self.states_Shader[self.current_Shader_idx]
end

function ShaderManager:draw()

    if self.current_Shader == self.states_Shader[1] then
        love.graphics.setShader(currentNormalShader)
    elseif self.current_Shader == self.states_Shader[2] then
        love.graphics.setShader(currentGrayedShader)
    elseif self.current_Shader == self.states_Shader[3] then
        love.graphics.setShader(currentVBShader)
    elseif self.current_Shader == self.states_Shader[4] then
        love.graphics.setShader(currentGBShader)
    elseif self.current_Shader == self.states_Shader[5] then
        love.graphics.setShader(currentPico8Shader)
    elseif self.current_Shader == self.states_Shader[6] then
        love.graphics.setShader(currentPinkShader)
    elseif self.current_Shader == self.states_Shader[7] then
        love.graphics.setShader(currentBananaShader)
    elseif self.current_Shader == self.states_Shader[8] then
        love.graphics.setShader(currentSeaShader)
    elseif self.current_Shader == self.states_Shader[9] then
        love.graphics.setShader(currentBreakGold)
    elseif self.current_Shader == self.states_Shader[10] then
        love.graphics.setShader(currentModernGold)
    elseif self.current_Shader == self.states_Shader[11] then
        love.graphics.setShader(currentFinlandPhoneColor)
    elseif self.current_Shader == self.states_Shader[12] then
        love.graphics.setShader(kawaiancolor)
    elseif self.current_Shader == self.states_Shader[13] then
        love.graphics.setShader(halfRetro)
    elseif self.current_Shader == self.states_Shader[14] then
        love.graphics.setShader(rainbowAround)
    elseif self.current_Shader == self.states_Shader[15] then
        love.graphics.setShader(darkaqua)
    elseif self.current_Shader == self.states_Shader[16] then
        love.graphics.setShader(whatisworld)
    elseif self.current_Shader == self.states_Shader[17] then
        love.graphics.setShader(nightneon)
    end
end

function ShaderManager:ChangeShader()
    if self.current_Shader_idx < 17 then
        self.current_Shader_idx = self.current_Shader_idx + 1
    elseif self.current_Shader_idx >= 17 then
        self.current_Shader_idx = 1
    end

    self.current_Shader = self.states_Shader[self.current_Shader_idx]
end

C_ShaderManager = ShaderManager:new()