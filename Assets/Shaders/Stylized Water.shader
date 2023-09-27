Shader "Custom/StylizedWaterShader"
{
    Properties
    {
        _Color ("Water Color", Color) = (1,1,1,1)
        _MainTex ("Water Texture (RGB)", 2D) = "white" {}
        _BumpMap ("BumpMap", 2D) = "bump" {}
        _OcclusionMap ("Occlusion Map", 2D) = "white" {}
        _BaseMap ("Base Color Map", 2D) = "white" {}
        _EmissiveMap ("Emissive Map", 2D) = "black" {}
        _HeightMap ("Height Map", 2D) = "white" {}
        _RoughnessMap ("Roughness Map", 2D) = "white" {}
        _WaveHeight ("Wave Height", Range(0,1)) = 0.1
        _WaveSpeed ("Wave Speed", Range(0,1)) = 0.5
        _Glossiness ("Smoothness", Range(0,1)) = 0.7
        _Metallic ("Metallic", Range(0,1)) = 0.2
        _MainTexScale ("Main Texture Scale", Range(1, 50)) = 10
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _OcclusionMap;
        sampler2D _BaseMap;
        sampler2D _EmissiveMap;
        sampler2D _HeightMap;
        sampler2D _RoughnessMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float2 uv_OcclusionMap;
            float2 uv_BaseMap;
            float2 uv_EmissiveMap;
            float2 uv_HeightMap;
            float2 uv_RoughnessMap;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float _WaveHeight;
        float _WaveSpeed;
        half _MainTexScale;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float wavePattern = _WaveHeight * sin(_Time.y * _WaveSpeed + IN.uv_MainTex.x);
            IN.uv_MainTex.y += wavePattern;
            IN.uv_BumpMap.y += wavePattern;
            IN.uv_OcclusionMap.y += wavePattern;
            IN.uv_BaseMap.y += wavePattern;
            IN.uv_EmissiveMap.y += wavePattern;
            IN.uv_HeightMap.y += wavePattern;
            IN.uv_RoughnessMap.y += wavePattern;

            // Albedo comes from the base color map
            fixed4 c = tex2D (_BaseMap, IN.uv_BaseMap * _MainTexScale);
            o.Albedo = c.rgb;

            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Occlusion = tex2D(_OcclusionMap, IN.uv_OcclusionMap).r;
            o.Emission = tex2D(_EmissiveMap, IN.uv_EmissiveMap).rgb;

            // Metallic and glossiness/roughness properties
            o.Metallic = _Metallic;
            o.Smoothness = 1 - tex2D(_RoughnessMap, IN.uv_RoughnessMap).r;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
