# Stylized Water Shader for Unity

A custom stylized water shader for Unity that incorporates textures and dynamic wave simulation.

## Installation

1. Download the shader file (`StylizedWaterShader.shader`).
2. Place the shader file in your Unity project, under the Assets folder.

## Usage

### Creating a Material

1. Go to the Unity editor.
2. Click on **Assets** -> **Create** -> **Material**.
3. Give it a name (like "StylizedWater").

### Assigning the Shader

1. With the newly created material selected, go to the Inspector.
2. In the **Shader** dropdown, select "Custom" -> "StylizedWaterShader".

### Setting up Properties

Inside the Inspector, you now have various properties that you can tweak:

- **Color**: The base color that gets multiplied with the Albedo (RGB) texture.
- **MainTex**: The main texture of your water.
- **BumpMap**: A normal map to simulate small waves on the water surface.
- **Wave Height**: Max height of the waves.
- **Wave Speed**: Speed of the waves.
- **Smoothness**: How smooth or glossy the surface appears.
- **Metallic**: How metallic the surface appears.

### Applying the Material

Finally, to apply the material to your game object, drag and drop the material onto the game object or assign it in the Mesh Renderer of the object.

## License

This software is released under the terms of [INSERT_LICENSE_HERE].
