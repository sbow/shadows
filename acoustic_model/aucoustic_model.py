import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Define sound source properties
soundLevelDB = 110
soundIntensityReference = 1e-12  # Watts per square meter

# Calculate sound source intensity
sourceIntensity = soundIntensityReference * 10**(soundLevelDB / 10)

# Define positions
sourcePosition = np.array([-400, 0, 10])  # 3D coordinates

# Simulation area
xRange = np.linspace(-450, 450, 1000)  # 1000 points for smoothness
yRange = np.linspace(-250, 250, 1000)
X, Y = np.meshgrid(xRange, yRange)

# Sound intensity calculation function
def intensity_function(x, y, sourceIntensity=sourceIntensity, sourcePosition=sourcePosition):
    distance_squared = (x - sourcePosition[0])**2 + (y - sourcePosition[1])**2
    intensity = sourceIntensity / (4 * np.pi * distance_squared)
    return intensity

# Generate the sound intensity over the grid
Z = intensity_function(X, Y)

# Generate the contour plot
plt.figure(figsize=(10, 6))
contour = plt.contourf(X, Y, Z, levels=50, cmap='rainbow')
plt.colorbar(contour)
plt.title('Sound Intensity Distribution')
plt.xlabel('X position (m)')
plt.ylabel('Y position (m)')
plt.show()