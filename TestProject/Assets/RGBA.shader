Shader "Custom/RGBA" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Ramp2D("BDRF", 2D) = "gray" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Ramp

		sampler2D _MainTex;
		sampler2D _Ramp2D;

		struct Input {
			float2 uv_MainTex;
		};

		half4 LightingRamp(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
		
			float NdotL = dot(s.Normal, lightDir);
			float NdotE = dot(s.Normal, viewDir);
			
			float diff =  (NdotL * 0.5) + 0.5;
			float2 brdfUV = float2(NdotE, diff);
			float3 BRDF = tex2D(_Ramp2D, brdfUV.xy).rgb;
			
			float4 c;
			
			c.rgb = BRDF;//float3(diff,diff,diff);
			c.a = s.Alpha;
			return c;
		
		}
		
		void surf (Input IN, inout SurfaceOutput o) {
			//half4 c = tex2D (_MainTex, IN.uv_MainTex);
			half4 c = float4(.5,.5,.5,1);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
