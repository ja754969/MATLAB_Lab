/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: fuel_rate_control.c
 *
 * Code generated for Simulink model 'fuel_rate_control'.
 *
 * Model version                  : 1.742
 * Simulink Coder version         : 9.1 (R2019a) 23-Nov-2018
 * C/C++ source code generated on : Wed Feb 19 11:21:58 2020
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Specified
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "fuel_rate_control.h"

/* Named constants for Chart: '<S1>/control_logic' */
#define CALL_EVENT                     (-1)
#define IN_A                           ((uint8_T)1U)
#define IN_Four                        ((uint8_T)1U)
#define IN_Fuel_Disabled               ((uint8_T)1U)
#define IN_Low_Emissions               ((uint8_T)1U)
#define IN_Multi                       ((uint8_T)1U)
#define IN_NO_ACTIVE_CHILD             ((uint8_T)0U)
#define IN_None                        ((uint8_T)2U)
#define IN_Normal                      ((uint8_T)1U)
#define IN_O2_failure                  ((uint8_T)1U)
#define IN_O2_normal                   ((uint8_T)2U)
#define IN_O2_warmup                   ((uint8_T)3U)
#define IN_One                         ((uint8_T)3U)
#define IN_Overspeed                   ((uint8_T)1U)
#define IN_Rich_Mixture                ((uint8_T)2U)
#define IN_Running                     ((uint8_T)2U)
#define IN_Shutdown                    ((uint8_T)2U)
#define IN_Single_Failure              ((uint8_T)1U)
#define IN_Three                       ((uint8_T)2U)
#define IN_Two                         ((uint8_T)3U)
#define IN_Warmup                      ((uint8_T)2U)
#define IN_fail                        ((uint8_T)1U)
#define IN_normal                      ((uint8_T)2U)
#define entry_to_Multi                 (23)
#define event_DEC                      (0)
#define event_INC                      (1)
#define exit_from_Multi                (24)

/* Block signals and states (default storage) */
DW rtDW;

/* External inputs (root inport signals with default storage) */
ExtU rtU;

/* External outputs (root outports fed by signals with default storage) */
ExtY rtY;

/* Real-time model */
RT_MODEL rtM_;
RT_MODEL *const rtM = &rtM_;
static real32_T look2_iflf_linlca(real32_T u0, real32_T u1, const real32_T bp0[],
  const real32_T bp1[], const real32_T table[], const uint32_T maxIndex[],
  uint32_T stride);

/* Forward declaration for local functions */
static void Fueling_Mode(const int32_T *sfEvent);
static void Fail(int32_T *sfEvent);
static real32_T look2_iflf_linlca(real32_T u0, real32_T u1, const real32_T bp0[],
  const real32_T bp1[], const real32_T table[], const uint32_T maxIndex[],
  uint32_T stride)
{
  real32_T y;
  real32_T frac;
  uint32_T bpIndices[2];
  real32_T fractions[2];
  real32_T yR_1d;
  uint32_T offset_1d;
  uint32_T bpIdx;

  /* Column-major Lookup 2-D
     Search method: 'linear'
     Use previous index: 'off'
     Interpolation method: 'Linear point-slope'
     Extrapolation method: 'Clip'
     Use last breakpoint for index at or above upper limit: 'on'
     Remove protection against out-of-range input in generated code: 'off'
   */
  /* Prelookup - Index and Fraction
     Index Search method: 'linear'
     Extrapolation method: 'Clip'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'on'
     Remove protection against out-of-range input in generated code: 'off'
   */
  if (u0 <= bp0[0U]) {
    bpIdx = 0U;
    frac = 0.0F;
  } else if (u0 < bp0[maxIndex[0U]]) {
    /* Linear Search */
    for (bpIdx = maxIndex[0U] >> 1U; u0 < bp0[bpIdx]; bpIdx--) {
    }

    while (u0 >= bp0[bpIdx + 1U]) {
      bpIdx++;
    }

    frac = (u0 - bp0[bpIdx]) / (bp0[bpIdx + 1U] - bp0[bpIdx]);
  } else {
    bpIdx = maxIndex[0U];
    frac = 0.0F;
  }

  fractions[0U] = frac;
  bpIndices[0U] = bpIdx;

  /* Prelookup - Index and Fraction
     Index Search method: 'linear'
     Extrapolation method: 'Clip'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'on'
     Remove protection against out-of-range input in generated code: 'off'
   */
  if (u1 <= bp1[0U]) {
    bpIdx = 0U;
    frac = 0.0F;
  } else if (u1 < bp1[maxIndex[1U]]) {
    /* Linear Search */
    for (bpIdx = maxIndex[1U] >> 1U; u1 < bp1[bpIdx]; bpIdx--) {
    }

    while (u1 >= bp1[bpIdx + 1U]) {
      bpIdx++;
    }

    frac = (u1 - bp1[bpIdx]) / (bp1[bpIdx + 1U] - bp1[bpIdx]);
  } else {
    bpIdx = maxIndex[1U];
    frac = 0.0F;
  }

  /* Column-major Interpolation 2-D
     Interpolation method: 'Linear point-slope'
     Use last breakpoint for index at or above upper limit: 'on'
     Overflow mode: 'wrapping'
   */
  offset_1d = bpIdx * stride + bpIndices[0U];
  if (bpIndices[0U] == maxIndex[0U]) {
    y = table[offset_1d];
  } else {
    y = (table[offset_1d + 1U] - table[offset_1d]) * fractions[0U] +
      table[offset_1d];
  }

  if (bpIdx == maxIndex[1U]) {
  } else {
    bpIdx = offset_1d + stride;
    if (bpIndices[0U] == maxIndex[0U]) {
      yR_1d = table[bpIdx];
    } else {
      yR_1d = (table[bpIdx + 1U] - table[bpIdx]) * fractions[0U] + table[bpIdx];
    }

    y += (yR_1d - y) * frac;
  }

  return y;
}

/* Function for Chart: '<S1>/control_logic' */
static void Fueling_Mode(const int32_T *sfEvent)
{
  /* This state interprets the other states in the chart to directly control the fueling mode. */
  switch (rtDW.bitsForTID0.is_Fueling_Mode) {
   case IN_Fuel_Disabled:
    rtDW.fuel_mode = DISABLED;

    /* The fuel is completely shut off while in this state. */
    switch (rtDW.bitsForTID0.is_Fuel_Disabled) {
     case IN_Overspeed:
      /* Inport: '<Root>/sensors' */
      /* The speed is dangerously high, so shut off the fuel. */
      if ((rtDW.bitsForTID0.is_Speed == IN_normal) && (rtU.sensors.speed <
           603.0F)) {
        if (rtDW.bitsForTID0.is_Fail != IN_Multi) {
          rtDW.bitsForTID0.is_Fuel_Disabled = IN_NO_ACTIVE_CHILD;
          rtDW.bitsForTID0.is_Fueling_Mode = IN_Running;
          switch (rtDW.bitsForTID0.was_Running) {
           case IN_Low_Emissions:
            rtDW.bitsForTID0.is_Running = IN_Low_Emissions;
            rtDW.bitsForTID0.was_Running = IN_Low_Emissions;
            rtDW.fuel_mode = LOW;
            switch (rtDW.bitsForTID0.was_Low_Emissions) {
             case IN_Normal:
              rtDW.bitsForTID0.is_Low_Emissions = IN_Normal;
              rtDW.bitsForTID0.was_Low_Emissions = IN_Normal;
              break;

             case IN_Warmup:
              rtDW.bitsForTID0.is_Low_Emissions = IN_Warmup;
              rtDW.bitsForTID0.was_Low_Emissions = IN_Warmup;
              break;
            }
            break;

           case IN_Rich_Mixture:
            rtDW.bitsForTID0.is_Running = IN_Rich_Mixture;
            rtDW.bitsForTID0.was_Running = IN_Rich_Mixture;
            rtDW.fuel_mode = RICH;
            rtDW.bitsForTID0.is_Rich_Mixture = IN_Single_Failure;
            break;
          }
        } else {
          if (rtDW.bitsForTID0.is_Fail == IN_Multi) {
            rtDW.bitsForTID0.is_Fuel_Disabled = IN_Shutdown;
          }
        }
      }

      /* End of Inport: '<Root>/sensors' */
      break;

     case IN_Shutdown:
      /* Cut off system operation due to multiple sensor failures. */
      if (*sfEvent == exit_from_Multi) {
        rtDW.bitsForTID0.is_Fuel_Disabled = IN_NO_ACTIVE_CHILD;
        rtDW.bitsForTID0.is_Fueling_Mode = IN_Running;
        rtDW.bitsForTID0.is_Running = IN_Rich_Mixture;
        rtDW.bitsForTID0.was_Running = IN_Rich_Mixture;
        rtDW.fuel_mode = RICH;
        rtDW.bitsForTID0.is_Rich_Mixture = IN_Single_Failure;
      }
      break;
    }
    break;

   case IN_Running:
    /* The fuel is actively controlled while in this state. */
    if (*sfEvent == entry_to_Multi) {
      rtDW.bitsForTID0.is_Low_Emissions = IN_NO_ACTIVE_CHILD;
      rtDW.bitsForTID0.is_Rich_Mixture = IN_NO_ACTIVE_CHILD;
      rtDW.bitsForTID0.is_Running = IN_NO_ACTIVE_CHILD;
      rtDW.bitsForTID0.is_Fueling_Mode = IN_Fuel_Disabled;
      rtDW.fuel_mode = DISABLED;
      rtDW.bitsForTID0.is_Fuel_Disabled = IN_Shutdown;
    } else if (rtU.sensors.speed > 628.0F) {
      rtDW.bitsForTID0.is_Low_Emissions = IN_NO_ACTIVE_CHILD;
      rtDW.bitsForTID0.is_Rich_Mixture = IN_NO_ACTIVE_CHILD;
      rtDW.bitsForTID0.is_Running = IN_NO_ACTIVE_CHILD;
      rtDW.bitsForTID0.is_Fueling_Mode = IN_Fuel_Disabled;
      rtDW.fuel_mode = DISABLED;
      rtDW.bitsForTID0.is_Fuel_Disabled = IN_Overspeed;
    } else {
      switch (rtDW.bitsForTID0.is_Running) {
       case IN_Low_Emissions:
        rtDW.fuel_mode = LOW;
        switch (rtDW.bitsForTID0.is_Low_Emissions) {
         case IN_Normal:
          /* All sensors are in correct operating modes, so effective closed-loop mixture control can be used. */
          if (rtDW.bitsForTID0.is_Fail == IN_One) {
            rtDW.bitsForTID0.is_Low_Emissions = IN_NO_ACTIVE_CHILD;
            rtDW.bitsForTID0.is_Running = IN_Rich_Mixture;
            rtDW.bitsForTID0.was_Running = IN_Rich_Mixture;
            rtDW.fuel_mode = RICH;
            rtDW.bitsForTID0.is_Rich_Mixture = IN_Single_Failure;
          }
          break;

         case IN_Warmup:
          /* The sensors are all operational, but the oxygen (EGO) sensor is warming up.  We'll target a stoichiometric ratio, nonetheless, but won't close the loop around exhaust gas oxygen. */
          if (rtDW.bitsForTID0.is_A == IN_O2_normal) {
            if (rtDW.bitsForTID0.is_Fail == IN_One) {
              rtDW.bitsForTID0.is_Low_Emissions = IN_NO_ACTIVE_CHILD;
              rtDW.bitsForTID0.is_Running = IN_Rich_Mixture;
              rtDW.bitsForTID0.was_Running = IN_Rich_Mixture;
              rtDW.fuel_mode = RICH;
              rtDW.bitsForTID0.is_Rich_Mixture = IN_Single_Failure;
            } else {
              rtDW.bitsForTID0.is_Low_Emissions = IN_Normal;
              rtDW.bitsForTID0.was_Low_Emissions = IN_Normal;
            }
          }
          break;
        }
        break;

       case IN_Rich_Mixture:
        rtDW.fuel_mode = RICH;

        /* This mode enriches the mixture, lowering the air/fuel ratio. */
        if ((rtDW.bitsForTID0.is_Rich_Mixture == IN_Single_Failure) &&
            (rtDW.bitsForTID0.is_Fail == IN_None)) {
          /* Continue uninterrupted engine operation, but with a richer mixture. */
          rtDW.bitsForTID0.is_Rich_Mixture = IN_NO_ACTIVE_CHILD;
          rtDW.bitsForTID0.is_Running = IN_Low_Emissions;
          rtDW.bitsForTID0.was_Running = IN_Low_Emissions;
          rtDW.fuel_mode = LOW;
          rtDW.bitsForTID0.is_Low_Emissions = IN_Normal;
          rtDW.bitsForTID0.was_Low_Emissions = IN_Normal;
        }
        break;
      }
    }
    break;
  }
}

/* Function for Chart: '<S1>/control_logic' */
static void Fail(int32_T *sfEvent)
{
  int32_T b_previousEvent;

  /* This state maintains a count of the number of sensors in failure mode. */
  switch (rtDW.bitsForTID0.is_Fail) {
   case IN_Multi:
    /* This state represents any of the conditions in which more than one sensor is in failure mode. */
    switch (rtDW.bitsForTID0.is_Multi) {
     case IN_Four:
      /* All four of the engine sensors have failed. */
      if (*sfEvent == event_DEC) {
        rtDW.bitsForTID0.is_Multi = IN_Three;
      }
      break;

     case IN_Three:
      /* Three of the engine sensors have failed. */
      switch (*sfEvent) {
       case event_INC:
        rtDW.bitsForTID0.is_Multi = IN_Four;
        break;

       case event_DEC:
        rtDW.bitsForTID0.is_Multi = IN_Two;
        break;
      }
      break;

     case IN_Two:
      /* Two of the engine sensors have failed. */
      switch (*sfEvent) {
       case event_DEC:
        rtDW.bitsForTID0.is_Multi = IN_NO_ACTIVE_CHILD;
        rtDW.bitsForTID0.is_Fail = IN_NO_ACTIVE_CHILD;
        b_previousEvent = *sfEvent;
        *sfEvent = exit_from_Multi;
        if (rtDW.bitsForTID0.is_active_Fueling_Mode != 0U) {
          Fueling_Mode(sfEvent);
        }

        *sfEvent = b_previousEvent;
        rtDW.bitsForTID0.is_Fail = IN_One;
        break;

       case event_INC:
        rtDW.bitsForTID0.is_Multi = IN_Three;
        break;
      }
      break;
    }
    break;

   case IN_None:
    /* Zero failures; all sensors are operational. */
    if (*sfEvent == event_INC) {
      rtDW.bitsForTID0.is_Fail = IN_One;
    }
    break;

   case IN_One:
    /* One of the engine sensors has failed. */
    switch (*sfEvent) {
     case event_INC:
      rtDW.bitsForTID0.is_Fail = IN_Multi;
      b_previousEvent = *sfEvent;
      *sfEvent = entry_to_Multi;
      if (rtDW.bitsForTID0.is_active_Fueling_Mode != 0U) {
        Fueling_Mode(sfEvent);
      }

      *sfEvent = b_previousEvent;
      rtDW.bitsForTID0.is_Multi = IN_Two;
      break;

     case event_DEC:
      rtDW.bitsForTID0.is_Fail = IN_None;
      break;
    }
    break;
  }
}

/* Model step function */
void fuel_rate_control_step(void)
{
  real32_T denAccum;
  real32_T rtb_MultiportSwitch;
  int32_T sfEvent;
  real32_T u0;

  /* Outputs for Atomic SubSystem: '<Root>/fuel_rate_control' */
  /* Chart: '<S1>/control_logic' incorporates:
   *  Inport: '<Root>/sensors'
   *  Lookup_n-D: '<S7>/Pressure Estimation'
   *  Lookup_n-D: '<S9>/Throttle Estimation'
   *
   * Block description for '<S1>/control_logic':
   *  Stateflow diagram to determine control system operating mode
   */
  sfEvent = CALL_EVENT;
  if (rtDW.temporalCounter_i1 < 511U) {
    rtDW.temporalCounter_i1++;
  }

  if (rtDW.bitsForTID0.is_active_c1_fuel_rate_control == 0U) {
    rtDW.bitsForTID0.is_active_c1_fuel_rate_control = 1U;
    rtDW.bitsForTID0.is_active_O2 = 1U;
    rtDW.bitsForTID0.is_O2 = IN_A;
    rtDW.bitsForTID0.is_A = IN_O2_warmup;
    rtDW.temporalCounter_i1 = 0U;
    rtDW.bitsForTID0.is_active_Pressure = 1U;
    rtDW.bitsForTID0.is_Pressure = IN_normal;
    rtDW.bitsForTID0.is_active_Throttle = 1U;
    rtDW.bitsForTID0.is_Throttle = IN_normal;
    rtDW.bitsForTID0.is_active_Speed = 1U;
    rtDW.bitsForTID0.is_Speed = IN_normal;
    rtDW.bitsForTID0.is_active_Fail = 1U;
    rtDW.bitsForTID0.is_Fail = IN_None;
    rtDW.bitsForTID0.is_active_Fueling_Mode = 1U;
    rtDW.es_o = rtU.sensors;

    /* Need to copy the sensors to the output on entry since the individual elements of the bus signal are only updated in the during function. */
    rtDW.bitsForTID0.is_Fueling_Mode = IN_Running;
    rtDW.bitsForTID0.is_Running = IN_Low_Emissions;
    rtDW.bitsForTID0.was_Running = IN_Low_Emissions;
    rtDW.fuel_mode = LOW;
    rtDW.bitsForTID0.is_Low_Emissions = IN_Warmup;
    rtDW.bitsForTID0.was_Low_Emissions = IN_Warmup;
  } else {
    if ((rtDW.bitsForTID0.is_active_O2 != 0U) && (rtDW.bitsForTID0.is_O2 == IN_A))
    {
      /* This state determines the validity of the exhaust gas oxygen sensor (EGO) data. */
      rtDW.es_o.ego = rtU.sensors.ego;
      switch (rtDW.bitsForTID0.is_A) {
       case IN_O2_failure:
        /* The EGO sensor has failed. */
        if (rtU.sensors.ego < 1.2F) {
          rtDW.bitsForTID0.is_A = IN_NO_ACTIVE_CHILD;
          sfEvent = event_DEC;
          if (rtDW.bitsForTID0.is_active_Fail != 0U) {
            Fail(&sfEvent);
          }

          sfEvent = CALL_EVENT;
          rtDW.bitsForTID0.is_A = IN_O2_normal;
          rtDW.bitsForTID0.O2_normal = true;
        }
        break;

       case IN_O2_normal:
        /* Normal EGO sensor operation gives a reliable indication of excess oxygen in the exhaust gas, from which air/fuel mixture can be inferred. */
        if (rtU.sensors.ego > 1.2F) {
          /* The failure condition is indicated by excessive output voltage. */
          rtDW.bitsForTID0.O2_normal = false;
          rtDW.bitsForTID0.is_A = IN_NO_ACTIVE_CHILD;
          sfEvent = event_INC;
          if (rtDW.bitsForTID0.is_active_Fail != 0U) {
            Fail(&sfEvent);
          }

          sfEvent = CALL_EVENT;
          rtDW.bitsForTID0.is_A = IN_O2_failure;
        }
        break;

       case IN_O2_warmup:
        /* The EGO sensor must come up to temperature before its data is reliable. */
        if (rtDW.temporalCounter_i1 >= 480) {
          /* The value for sufficient warm up to operational temperature (nominally 4.8 seconds). */
          rtDW.bitsForTID0.is_A = IN_O2_normal;
          rtDW.bitsForTID0.O2_normal = true;
        }
        break;
      }
    }

    if (rtDW.bitsForTID0.is_active_Pressure != 0U) {
      /* This state assesses the validity of the manifold absolute pressure (MAP) sensor. */
      switch (rtDW.bitsForTID0.is_Pressure) {
       case IN_fail:
        /* The pressure sensor (manifold, or MAP) no longer produces reliable data. */
        if ((rtU.sensors.map > 0.05F) && (rtU.sensors.map < 0.95F)) {
          rtDW.bitsForTID0.is_Pressure = IN_NO_ACTIVE_CHILD;
          sfEvent = event_DEC;
          if (rtDW.bitsForTID0.is_active_Fail != 0U) {
            Fail(&sfEvent);
          }

          sfEvent = -1;
          rtDW.bitsForTID0.is_Pressure = IN_normal;
        } else {
          /* Outputs for Function Call SubSystem: '<S3>/Pressure.map_estimate' */
          rtDW.es_o.map = look2_iflf_linlca(rtU.sensors.speed,
            rtU.sensors.throttle, rtConstP.pooled1, rtConstP.pooled2,
            rtConstP.PressureEstimation_tableData,
            rtConstP.PressureEstimation_maxIndex, 18U);

          /* End of Outputs for SubSystem: '<S3>/Pressure.map_estimate' */
        }
        break;

       case IN_normal:
        /* The manifold pressure sensor gives a reliable indication of absolute pressure (MAP). */
        if ((rtU.sensors.map > 0.95F) || (rtU.sensors.map < 0.05F)) {
          rtDW.bitsForTID0.is_Pressure = IN_NO_ACTIVE_CHILD;
          sfEvent = event_INC;
          if (rtDW.bitsForTID0.is_active_Fail != 0U) {
            Fail(&sfEvent);
          }

          sfEvent = -1;
          rtDW.bitsForTID0.is_Pressure = IN_fail;
        } else {
          rtDW.es_o.map = rtU.sensors.map;
        }
        break;
      }
    }

    if (rtDW.bitsForTID0.is_active_Throttle != 0U) {
      /* This state determines the validity of the throttle sensor signal. */
      switch (rtDW.bitsForTID0.is_Throttle) {
       case IN_fail:
        /* Signal levels indicate that the throttle sensor data is no longer valid. */
        if ((rtU.sensors.throttle > 3.0F) && (rtU.sensors.throttle < 90.0F)) {
          rtDW.bitsForTID0.is_Throttle = IN_NO_ACTIVE_CHILD;
          sfEvent = event_DEC;
          if (rtDW.bitsForTID0.is_active_Fail != 0U) {
            Fail(&sfEvent);
          }

          sfEvent = -1;
          rtDW.bitsForTID0.is_Throttle = IN_normal;
        } else {
          /* Outputs for Function Call SubSystem: '<S3>/Throttle.throttle_estimate' */
          rtDW.es_o.throttle = look2_iflf_linlca(rtU.sensors.speed,
            rtU.sensors.map, rtConstP.pooled1, rtConstP.pooled3,
            rtConstP.ThrottleEstimation_tableData, rtConstP.pooled8, 18U);

          /* End of Outputs for SubSystem: '<S3>/Throttle.throttle_estimate' */
        }
        break;

       case IN_normal:
        /* The throttle sensor gives a reliable indication of the angle of the throttle plate. */
        if ((rtU.sensors.throttle > 90.0F) || (rtU.sensors.throttle < 3.0F)) {
          /* A failure is indicated by data which is outside the expected range, typically due to an open or short circuit. */
          rtDW.bitsForTID0.is_Throttle = IN_NO_ACTIVE_CHILD;
          sfEvent = event_INC;
          if (rtDW.bitsForTID0.is_active_Fail != 0U) {
            Fail(&sfEvent);
          }

          sfEvent = -1;
          rtDW.bitsForTID0.is_Throttle = IN_fail;
        } else {
          rtDW.es_o.throttle = rtU.sensors.throttle;
        }
        break;
      }
    }

    if (rtDW.bitsForTID0.is_active_Speed != 0U) {
      /* This state infers the validity of the speed sensor data.  A failure is indicated by the presence of manifold vacuum at zero speed. */
      switch (rtDW.bitsForTID0.is_Speed) {
       case IN_fail:
        /* The engine speed data is no longer available. */
        if (rtU.sensors.speed > 0.0F) {
          rtDW.bitsForTID0.is_Speed = IN_NO_ACTIVE_CHILD;
          sfEvent = event_DEC;
          if (rtDW.bitsForTID0.is_active_Fail != 0U) {
            Fail(&sfEvent);
          }

          sfEvent = -1;
          rtDW.bitsForTID0.is_Speed = IN_normal;
        } else {
          /* Outputs for Function Call SubSystem: '<S3>/Speed.speed_estimate' */
          /* Lookup_n-D: '<S8>/Speed Estimation' */
          u0 = look2_iflf_linlca(rtU.sensors.throttle, rtU.sensors.map,
            rtConstP.pooled2, rtConstP.pooled3,
            rtConstP.SpeedEstimation_tableData,
            rtConstP.SpeedEstimation_maxIndex, 17U);

          /* Saturate: '<S8>/Saturation' */
          if (u0 > 628.0F) {
            rtDW.es_o.speed = 628.0F;
          } else if (u0 < 0.0F) {
            rtDW.es_o.speed = 0.0F;
          } else {
            rtDW.es_o.speed = u0;
          }

          /* End of Saturate: '<S8>/Saturation' */
          /* End of Outputs for SubSystem: '<S3>/Speed.speed_estimate' */
        }
        break;

       case IN_normal:
        /* The speed sensor data accurately represents the engine speed. */
        if ((rtU.sensors.speed == 0.0F) && (rtU.sensors.map < 250.0F)) {
          /* Loss of a reliable speed sensor signal will indicate zero speed.  This is deemed invalid when the manifold vacuum indicates otherwise. */
          rtDW.bitsForTID0.is_Speed = IN_NO_ACTIVE_CHILD;
          sfEvent = event_INC;
          if (rtDW.bitsForTID0.is_active_Fail != 0U) {
            Fail(&sfEvent);
          }

          sfEvent = -1;
          rtDW.bitsForTID0.is_Speed = IN_fail;
        } else {
          rtDW.es_o.speed = rtU.sensors.speed;
        }
        break;
      }
    }

    if (rtDW.bitsForTID0.is_active_Fail != 0U) {
      Fail(&sfEvent);
    }

    if (rtDW.bitsForTID0.is_active_Fueling_Mode != 0U) {
      Fueling_Mode(&sfEvent);
    }
  }

  /* End of Chart: '<S1>/control_logic' */

  /* DiscreteFilter: '<S2>/Throttle Transient' */
  u0 = rtDW.es_o.throttle - -0.8F * rtDW.ThrottleTransient_states;

  /* MultiPortSwitch: '<S10>/Multiport Switch' incorporates:
   *  Constant: '<S10>/normal'
   *  Constant: '<S10>/rich'
   *  Constant: '<S10>/shutdown'
   */
  switch (rtDW.fuel_mode) {
   case LOW:
    rtb_MultiportSwitch = 0.0684931502F;
    break;

   case RICH:
    rtb_MultiportSwitch = 0.0856164396F;
    break;

   default:
    rtb_MultiportSwitch = 0.0F;
    break;
  }

  /* End of MultiPortSwitch: '<S10>/Multiport Switch' */

  /* SwitchCase: '<S11>/Switch Case' */
  switch (rtDW.fuel_mode) {
   case LOW:
    /* Outputs for IfAction SubSystem: '<S11>/low_mode' incorporates:
     *  ActionPort: '<S13>/Action Port'
     */
    /* DiscreteFilter: '<S13>/Discrete Filter' incorporates:
     *  DiscreteIntegrator: '<S2>/Discrete Integrator'
     */
    denAccum = rtDW.DiscreteIntegrator_DSTATE - -0.7408F *
      rtDW.DiscreteFilter_states_i;

    /* Outport: '<Root>/fuel_rate' incorporates:
     *  DiscreteFilter: '<S13>/Discrete Filter'
     *  DiscreteFilter: '<S2>/Throttle Transient'
     *  Lookup_n-D: '<S2>/Pumping Constant'
     *  Product: '<S10>/Product'
     *  Product: '<S2>/Product'
     *  Product: '<S2>/Product2'
     *  Sum: '<S13>/Sum3'
     *  Sum: '<S2>/Sum'
     */
    rtY.fuel_rate = ((0.01F * u0 + -0.01F * rtDW.ThrottleTransient_states) +
                     rtDW.es_o.speed * look2_iflf_linlca(rtDW.es_o.speed,
      rtDW.es_o.map, rtConstP.pooled1, rtConstP.pooled3,
      rtConstP.PumpingConstant_tableData, rtConstP.pooled8, 18U) * rtDW.es_o.map)
      * rtb_MultiportSwitch + (8.7696F * denAccum + -8.5104F *
      rtDW.DiscreteFilter_states_i);

    /* Update for DiscreteFilter: '<S13>/Discrete Filter' */
    rtDW.DiscreteFilter_states_i = denAccum;

    /* End of Outputs for SubSystem: '<S11>/low_mode' */
    break;

   case RICH:
    /* Outputs for IfAction SubSystem: '<S11>/rich_mode' incorporates:
     *  ActionPort: '<S14>/Action Port'
     */
    /* Outport: '<Root>/fuel_rate' incorporates:
     *  DiscreteFilter: '<S14>/Discrete Filter'
     */
    rtY.fuel_rate = 0.2592F * rtDW.DiscreteFilter_states;

    /* Update for DiscreteFilter: '<S14>/Discrete Filter' incorporates:
     *  DiscreteFilter: '<S2>/Throttle Transient'
     *  DiscreteIntegrator: '<S2>/Discrete Integrator'
     *  Lookup_n-D: '<S2>/Pumping Constant'
     *  Product: '<S10>/Product'
     *  Product: '<S2>/Product'
     *  Product: '<S2>/Product2'
     *  Sum: '<S14>/Sum2'
     *  Sum: '<S2>/Sum'
     */
    rtDW.DiscreteFilter_states = (((0.01F * u0 + -0.01F *
      rtDW.ThrottleTransient_states) + rtDW.es_o.speed * look2_iflf_linlca
      (rtDW.es_o.speed, rtDW.es_o.map, rtConstP.pooled1, rtConstP.pooled3,
       rtConstP.PumpingConstant_tableData, rtConstP.pooled8, 18U) *
      rtDW.es_o.map) * rtb_MultiportSwitch + rtDW.DiscreteIntegrator_DSTATE) -
      -0.7408F * rtDW.DiscreteFilter_states;

    /* End of Outputs for SubSystem: '<S11>/rich_mode' */
    break;

   default:
    /* Outputs for IfAction SubSystem: '<S11>/disabled_mode' incorporates:
     *  ActionPort: '<S12>/Action Port'
     */
    /* Outport: '<Root>/fuel_rate' incorporates:
     *  Constant: '<S12>/shutoff'
     */
    rtY.fuel_rate = 0.0F;

    /* End of Outputs for SubSystem: '<S11>/disabled_mode' */
    break;
  }

  /* End of SwitchCase: '<S11>/Switch Case' */

  /* Update for DiscreteFilter: '<S2>/Throttle Transient' */
  rtDW.ThrottleTransient_states = u0;

  /* Switch: '<S2>/hold integrator' incorporates:
   *  Constant: '<S2>/Constant'
   *  Constant: '<S2>/Constant2'
   *  Constant: '<S2>/Oxygen Sensor Switching Threshold'
   *  Constant: '<S6>/Constant'
   *  DataTypeConversion: '<S2>/Data Type  Conversion'
   *  Logic: '<S2>/Logic1'
   *  Lookup_n-D: '<S2>/Ramp Rate Ki'
   *  Product: '<S2>/Product1'
   *  RelationalOperator: '<S2>/Relational Operator1'
   *  RelationalOperator: '<S2>/Relational Operator3'
   *  Sum: '<S2>/Sum1'
   */
  if (rtDW.bitsForTID0.O2_normal && (rtDW.fuel_mode == LOW)) {
    u0 = ((real32_T)(rtDW.es_o.ego <= 0.5F) - 0.5F) * look2_iflf_linlca
      (rtDW.es_o.speed, rtDW.es_o.map, rtConstP.RampRateKi_bp01Data,
       rtConstP.RampRateKi_bp02Data, rtConstP.RampRateKi_tableData,
       rtConstP.RampRateKi_maxIndex, 6U);
  } else {
    u0 = 0.0F;
  }

  /* End of Switch: '<S2>/hold integrator' */

  /* Update for DiscreteIntegrator: '<S2>/Discrete Integrator' */
  rtDW.DiscreteIntegrator_DSTATE += 0.01F * u0;

  /* End of Outputs for SubSystem: '<Root>/fuel_rate_control' */
}

/* Model initialize function */
void fuel_rate_control_initialize(void)
{
  /* Registration code */

  /* states (dwork) */
  {
    rtDW.fuel_mode = LOW;
  }

  /* SystemInitialize for Atomic SubSystem: '<Root>/fuel_rate_control' */
  /* SystemInitialize for Chart: '<S1>/control_logic'
   *
   * Block description for '<S1>/control_logic':
   *  Stateflow diagram to determine control system operating mode
   */
  rtDW.es_o.throttle = 0.0F;
  rtDW.es_o.speed = 0.0F;
  rtDW.es_o.ego = 0.0F;
  rtDW.es_o.map = 0.0F;
  rtDW.fuel_mode = LOW;

  /* End of SystemInitialize for SubSystem: '<Root>/fuel_rate_control' */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
