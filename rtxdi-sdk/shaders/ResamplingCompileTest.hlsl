/***************************************************************************
 # Copyright (c) 2020-2023, NVIDIA CORPORATION.  All rights reserved.
 #
 # NVIDIA CORPORATION and its licensors retain all intellectual property
 # and proprietary rights in and to this software, related documentation
 # and any modifications thereto.  Any use, reproduction, disclosure or
 # distribution of this software and related documentation without an express
 # license agreement from NVIDIA CORPORATION is strictly prohibited.
 **************************************************************************/

// This shader file is intended for testing the RTXDI header files to make sure
// that they do not make any undeclared assumptions about the contents of the 
// user-defined structures and about the functions being available.

#include <rtxdi/RtxdiParameters.h>

struct RAB_RandomSamplerState
{
    uint unused;
};

struct RAB_Surface
{
    uint unused;
};

struct RAB_LightSample
{
    uint unused;
};

struct RAB_LightInfo
{
    uint unused;
};

RAB_Surface RAB_EmptySurface()
{
    return RAB_Surface(0);
}

RAB_LightInfo RAB_EmptyLightInfo()
{
    return RAB_LightInfo(0);
}

RAB_LightSample RAB_EmptyLightSample()
{
    return RAB_LightSample(0);
}

void RAB_GetLightDirDistance(RAB_Surface surface, RAB_LightSample lightSample,
    out float3 o_lightDir,
    out float o_lightDistance)
{
}

bool RAB_GetConservativeVisibility(RAB_Surface surface, RAB_LightSample lightSample)
{
    return true;
}

bool RAB_GetTemporalConservativeVisibility(RAB_Surface currentSurface, RAB_Surface previousSurface, RAB_LightSample lightSample)
{
    return true;
}

int2 RAB_ClampSamplePositionIntoView(int2 pixelPosition, bool previousFrame)
{
    return pixelPosition;
}

RAB_Surface RAB_GetGBufferSurface(int2 pixelPosition, bool previousFrame)
{
    return (RAB_Surface)0;
}

bool RAB_IsSurfaceValid(RAB_Surface surface)
{
    return true;
}

float3 RAB_GetSurfaceWorldPos(RAB_Surface surface)
{
    return 0.0;
}

float3 RAB_GetSurfaceNormal(RAB_Surface surface)
{
    return 0.0;
}

float RAB_GetSurfaceLinearDepth(RAB_Surface surface)
{
    return 0.0;
}

float RAB_GetNextRandom(inout RAB_RandomSamplerState rng)
{
    return 0.0;
}

bool RAB_GetSurfaceBrdfSample(RAB_Surface surface, inout RAB_RandomSamplerState rng, out float3 dir)
{
    return true;
}

float RAB_GetSurfaceBrdfPdf(RAB_Surface surface, float3 dir)
{
    return 0.0;
}

float RAB_GetLightSampleTargetPdfForSurface(RAB_LightSample lightSample, RAB_Surface surface)
{
    return 1.0;
}

float RAB_GetLightTargetPdfForVolume(RAB_LightInfo light, float3 volumeCenter, float volumeRadius)
{
    return 1.0;
}

RAB_LightSample RAB_SamplePolymorphicLight(RAB_LightInfo lightInfo, RAB_Surface surface, float2 uv)
{
    return (RAB_LightSample)0;
}

RAB_LightInfo RAB_LoadLightInfo(uint index, bool previousFrame)
{
    return (RAB_LightInfo)0;
}

RAB_LightInfo RAB_LoadCompactLightInfo(uint linearIndex)
{
    return (RAB_LightInfo)0;
}

bool RAB_StoreCompactLightInfo(uint linearIndex, RAB_LightInfo lightInfo)
{
    return true;
}

int RAB_TranslateLightIndex(uint lightIndex, bool currentToPrevious)
{
    return -1;
}

float RAB_EvaluateLocalLightSourcePdf(RTXDI_ResamplingRuntimeParameters params, uint lightIndex)
{
    return 0.0;
}

bool RAB_IsAnalyticLightSample(RAB_LightSample lightSample)
{
    return false;
}

float RAB_LightSampleSolidAnglePdf(RAB_LightSample lightSample)
{
    return 0.0;
}

float RAB_EvaluateEnvironmentMapSamplingPdf(float3 L)
{
    return 0.0;
}

float2 RAB_GetEnvironmentMapRandXYFromDir(float3 worldDir)
{
    return 0.0;
}

bool RAB_TraceRayForLocalLight(float3 origin, float3 direction, float tMin, float tMax, out uint o_lightIndex, out float2 o_randXY)
{
    return false;
}

bool RAB_AreMaterialsSimilar(RAB_Surface a, RAB_Surface b)
{
    return true;
}

bool RAB_ValidateGISampleWithJacobian(inout float jacobian)
{
    return true;
}

float RAB_GetGISampleTargetPdfForSurface(float3 samplePosition, float3 sampleRadiance, RAB_Surface surface)
{
    return 1.0;
}

bool RAB_GetConservativeVisibility(RAB_Surface surface, float3 samplePosition)
{
    return true;
}

bool RAB_GetTemporalConservativeVisibility(RAB_Surface currentSurface, RAB_Surface previousSurface, float3 samplePosition)
{
    return true;
}

#define RTXDI_ENABLE_BOILING_FILTER
#define RTXDI_BOILING_FILTER_GROUP_SIZE 16

RWBuffer<uint2> u_RisBuffer;
RWStructuredBuffer<RTXDI_PackedReservoir> u_LightReservoirs;
RWStructuredBuffer<RTXDI_PackedGIReservoir> u_GIReservoirs;
Buffer<float2> t_NeighborOffsets;

#define RTXDI_RIS_BUFFER u_RisBuffer
#define RTXDI_LIGHT_RESERVOIR_BUFFER u_LightReservoirs
#define RTXDI_GI_RESERVOIR_BUFFER u_GIReservoirs
#define RTXDI_NEIGHBOR_OFFSETS_BUFFER t_NeighborOffsets

#include <rtxdi/ResamplingFunctions.hlsli>

[numthreads(1, 1, 1)]
void main()
{
}
