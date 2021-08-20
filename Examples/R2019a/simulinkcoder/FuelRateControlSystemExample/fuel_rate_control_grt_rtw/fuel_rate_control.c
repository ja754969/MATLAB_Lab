/*
 * fuel_rate_control.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "fuel_rate_control".
 *
 * Model version              : 1.742
 * Simulink Coder version : 9.1 (R2019a) 23-Nov-2018
 * C source code generated on : Wed Feb 19 11:21:37 2020
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Specified
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "fuel_rate_control.h"
#include "fuel_rate_control_private.h"

/* Named constants for Chart: '<S1>/control_logic' */
#define fuel_rate_co_IN_NO_ACTIVE_CHILD ((uint8_T)0U)
#define fuel_rate_con_IN_Single_Failure ((uint8_T)1U)
#define fuel_rate_cont_IN_Fuel_Disabled ((uint8_T)1U)
#define fuel_rate_cont_IN_Low_Emissions ((uint8_T)1U)
#define fuel_rate_contr_IN_Rich_Mixture ((uint8_T)2U)
#define fuel_rate_contr_exit_from_Multi (24)
#define fuel_rate_contro_entry_to_Multi (23)
#define fuel_rate_control_CALL_EVENT   (-1)
#define fuel_rate_control_IN_A         ((uint8_T)1U)
#define fuel_rate_control_IN_Four      ((uint8_T)1U)
#define fuel_rate_control_IN_Multi     ((uint8_T)1U)
#define fuel_rate_control_IN_None      ((uint8_T)2U)
#define fuel_rate_control_IN_Normal    ((uint8_T)1U)
#define fuel_rate_control_IN_O2_failure ((uint8_T)1U)
#define fuel_rate_control_IN_O2_normal ((uint8_T)2U)
#define fuel_rate_control_IN_O2_warmup ((uint8_T)3U)
#define fuel_rate_control_IN_One       ((uint8_T)3U)
#define fuel_rate_control_IN_Overspeed ((uint8_T)1U)
#define fuel_rate_control_IN_Running   ((uint8_T)2U)
#define fuel_rate_control_IN_Shutdown  ((uint8_T)2U)
#define fuel_rate_control_IN_Three     ((uint8_T)2U)
#define fuel_rate_control_IN_Two       ((uint8_T)3U)
#define fuel_rate_control_IN_Warmup    ((uint8_T)2U)
#define fuel_rate_control_IN_fail      ((uint8_T)1U)
#define fuel_rate_control_IN_normal    ((uint8_T)2U)
#define fuel_rate_control_event_DEC    (0)
#define fuel_rate_control_event_INC    (1)

/* Block signals (default storage) */
B_fuel_rate_control_T fuel_rate_control_B;

/* Block states (default storage) */
DW_fuel_rate_control_T fuel_rate_control_DW;

/* External inputs (root inport signals with default storage) */
ExtU_fuel_rate_control_T fuel_rate_control_U;

/* External outputs (root outports fed by signals with default storage) */
ExtY_fuel_rate_control_T fuel_rate_control_Y;

/* Real-time model */
RT_MODEL_fuel_rate_control_T fuel_rate_control_M_;
RT_MODEL_fuel_rate_control_T *const fuel_rate_control_M = &fuel_rate_control_M_;

/* Forward declaration for local functions */
static void fuel_rate_control_Fueling_Mode(void);
static void fuel_rate_control_Fail(void);
const EngSensors fuel_rate_control_rtZEngSensors = { 0.0F,/* throttle */
  0.0F,                                /* speed */
  0.0F,                                /* ego */
  0.0F                                 /* map */
};

real32_T look2_iflf_linlca(real32_T u0, real32_T u1, const real32_T bp0[], const
  real32_T bp1[], const real32_T table[], const uint32_T maxIndex[], uint32_T
  stride)
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
static void fuel_rate_control_Fueling_Mode(void)
{
  switch (fuel_rate_control_DW.bitsForTID0.is_Fueling_Mode) {
   case fuel_rate_cont_IN_Fuel_Disabled:
    fuel_rate_control_B.fuel_mode = DISABLED;
    switch (fuel_rate_control_DW.bitsForTID0.is_Fuel_Disabled) {
     case fuel_rate_control_IN_Overspeed:
      /* Inport: '<Root>/sensors' */
      if ((fuel_rate_control_DW.bitsForTID0.is_Speed ==
           fuel_rate_control_IN_normal) && (fuel_rate_control_U.sensors.speed <
           603.0F)) {
        if (fuel_rate_control_DW.bitsForTID0.is_Fail !=
            fuel_rate_control_IN_Multi) {
          fuel_rate_control_DW.bitsForTID0.is_Fuel_Disabled =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          fuel_rate_control_DW.bitsForTID0.is_Fueling_Mode =
            fuel_rate_control_IN_Running;
          switch (fuel_rate_control_DW.bitsForTID0.was_Running) {
           case fuel_rate_cont_IN_Low_Emissions:
            fuel_rate_control_DW.bitsForTID0.is_Running =
              fuel_rate_cont_IN_Low_Emissions;
            fuel_rate_control_DW.bitsForTID0.was_Running =
              fuel_rate_cont_IN_Low_Emissions;
            fuel_rate_control_B.fuel_mode = LOW;
            switch (fuel_rate_control_DW.bitsForTID0.was_Low_Emissions) {
             case fuel_rate_control_IN_Normal:
              fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
                fuel_rate_control_IN_Normal;
              fuel_rate_control_DW.bitsForTID0.was_Low_Emissions =
                fuel_rate_control_IN_Normal;
              break;

             case fuel_rate_control_IN_Warmup:
              fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
                fuel_rate_control_IN_Warmup;
              fuel_rate_control_DW.bitsForTID0.was_Low_Emissions =
                fuel_rate_control_IN_Warmup;
              break;

             default:
              fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
                fuel_rate_co_IN_NO_ACTIVE_CHILD;
              break;
            }
            break;

           case fuel_rate_contr_IN_Rich_Mixture:
            fuel_rate_control_DW.bitsForTID0.is_Running =
              fuel_rate_contr_IN_Rich_Mixture;
            fuel_rate_control_DW.bitsForTID0.was_Running =
              fuel_rate_contr_IN_Rich_Mixture;
            fuel_rate_control_B.fuel_mode = RICH;
            fuel_rate_control_DW.bitsForTID0.is_Rich_Mixture =
              fuel_rate_con_IN_Single_Failure;
            break;

           default:
            fuel_rate_control_DW.bitsForTID0.is_Running =
              fuel_rate_co_IN_NO_ACTIVE_CHILD;
            break;
          }
        } else {
          if (fuel_rate_control_DW.bitsForTID0.is_Fail ==
              fuel_rate_control_IN_Multi) {
            fuel_rate_control_DW.bitsForTID0.is_Fuel_Disabled =
              fuel_rate_control_IN_Shutdown;
          }
        }
      }

      /* End of Inport: '<Root>/sensors' */
      break;

     case fuel_rate_control_IN_Shutdown:
      if (fuel_rate_control_DW.sfEvent == fuel_rate_contr_exit_from_Multi) {
        fuel_rate_control_DW.bitsForTID0.is_Fuel_Disabled =
          fuel_rate_co_IN_NO_ACTIVE_CHILD;
        fuel_rate_control_DW.bitsForTID0.is_Fueling_Mode =
          fuel_rate_control_IN_Running;
        fuel_rate_control_DW.bitsForTID0.is_Running =
          fuel_rate_contr_IN_Rich_Mixture;
        fuel_rate_control_DW.bitsForTID0.was_Running =
          fuel_rate_contr_IN_Rich_Mixture;
        fuel_rate_control_B.fuel_mode = RICH;
        fuel_rate_control_DW.bitsForTID0.is_Rich_Mixture =
          fuel_rate_con_IN_Single_Failure;
      }
      break;

     default:
      /* Unreachable state, for coverage only */
      fuel_rate_control_DW.bitsForTID0.is_Fuel_Disabled =
        fuel_rate_co_IN_NO_ACTIVE_CHILD;
      break;
    }
    break;

   case fuel_rate_control_IN_Running:
    if (fuel_rate_control_DW.sfEvent == fuel_rate_contro_entry_to_Multi) {
      fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
        fuel_rate_co_IN_NO_ACTIVE_CHILD;
      fuel_rate_control_DW.bitsForTID0.is_Rich_Mixture =
        fuel_rate_co_IN_NO_ACTIVE_CHILD;
      fuel_rate_control_DW.bitsForTID0.is_Running =
        fuel_rate_co_IN_NO_ACTIVE_CHILD;
      fuel_rate_control_DW.bitsForTID0.is_Fueling_Mode =
        fuel_rate_cont_IN_Fuel_Disabled;
      fuel_rate_control_B.fuel_mode = DISABLED;
      fuel_rate_control_DW.bitsForTID0.is_Fuel_Disabled =
        fuel_rate_control_IN_Shutdown;
    } else if (fuel_rate_control_U.sensors.speed > 628.0F) {
      fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
        fuel_rate_co_IN_NO_ACTIVE_CHILD;
      fuel_rate_control_DW.bitsForTID0.is_Rich_Mixture =
        fuel_rate_co_IN_NO_ACTIVE_CHILD;
      fuel_rate_control_DW.bitsForTID0.is_Running =
        fuel_rate_co_IN_NO_ACTIVE_CHILD;
      fuel_rate_control_DW.bitsForTID0.is_Fueling_Mode =
        fuel_rate_cont_IN_Fuel_Disabled;
      fuel_rate_control_B.fuel_mode = DISABLED;
      fuel_rate_control_DW.bitsForTID0.is_Fuel_Disabled =
        fuel_rate_control_IN_Overspeed;
    } else {
      switch (fuel_rate_control_DW.bitsForTID0.is_Running) {
       case fuel_rate_cont_IN_Low_Emissions:
        fuel_rate_control_B.fuel_mode = LOW;
        switch (fuel_rate_control_DW.bitsForTID0.is_Low_Emissions) {
         case fuel_rate_control_IN_Normal:
          if (fuel_rate_control_DW.bitsForTID0.is_Fail ==
              fuel_rate_control_IN_One) {
            fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
              fuel_rate_co_IN_NO_ACTIVE_CHILD;
            fuel_rate_control_DW.bitsForTID0.is_Running =
              fuel_rate_contr_IN_Rich_Mixture;
            fuel_rate_control_DW.bitsForTID0.was_Running =
              fuel_rate_contr_IN_Rich_Mixture;
            fuel_rate_control_B.fuel_mode = RICH;
            fuel_rate_control_DW.bitsForTID0.is_Rich_Mixture =
              fuel_rate_con_IN_Single_Failure;
          }
          break;

         case fuel_rate_control_IN_Warmup:
          if (fuel_rate_control_DW.bitsForTID0.is_A ==
              fuel_rate_control_IN_O2_normal) {
            if (fuel_rate_control_DW.bitsForTID0.is_Fail ==
                fuel_rate_control_IN_One) {
              fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
                fuel_rate_co_IN_NO_ACTIVE_CHILD;
              fuel_rate_control_DW.bitsForTID0.is_Running =
                fuel_rate_contr_IN_Rich_Mixture;
              fuel_rate_control_DW.bitsForTID0.was_Running =
                fuel_rate_contr_IN_Rich_Mixture;
              fuel_rate_control_B.fuel_mode = RICH;
              fuel_rate_control_DW.bitsForTID0.is_Rich_Mixture =
                fuel_rate_con_IN_Single_Failure;
            } else {
              fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
                fuel_rate_control_IN_Normal;
              fuel_rate_control_DW.bitsForTID0.was_Low_Emissions =
                fuel_rate_control_IN_Normal;
            }
          }
          break;

         default:
          /* Unreachable state, for coverage only */
          fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          break;
        }
        break;

       case fuel_rate_contr_IN_Rich_Mixture:
        fuel_rate_control_B.fuel_mode = RICH;
        if ((fuel_rate_control_DW.bitsForTID0.is_Rich_Mixture ==
             fuel_rate_con_IN_Single_Failure) &&
            (fuel_rate_control_DW.bitsForTID0.is_Fail ==
             fuel_rate_control_IN_None)) {
          fuel_rate_control_DW.bitsForTID0.is_Rich_Mixture =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          fuel_rate_control_DW.bitsForTID0.is_Running =
            fuel_rate_cont_IN_Low_Emissions;
          fuel_rate_control_DW.bitsForTID0.was_Running =
            fuel_rate_cont_IN_Low_Emissions;
          fuel_rate_control_B.fuel_mode = LOW;
          fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
            fuel_rate_control_IN_Normal;
          fuel_rate_control_DW.bitsForTID0.was_Low_Emissions =
            fuel_rate_control_IN_Normal;
        }
        break;

       default:
        /* Unreachable state, for coverage only */
        fuel_rate_control_DW.bitsForTID0.is_Running =
          fuel_rate_co_IN_NO_ACTIVE_CHILD;
        break;
      }
    }
    break;

   default:
    /* Unreachable state, for coverage only */
    fuel_rate_control_DW.bitsForTID0.is_Fueling_Mode =
      fuel_rate_co_IN_NO_ACTIVE_CHILD;
    break;
  }
}

/* Function for Chart: '<S1>/control_logic' */
static void fuel_rate_control_Fail(void)
{
  int32_T b_previousEvent;
  switch (fuel_rate_control_DW.bitsForTID0.is_Fail) {
   case fuel_rate_control_IN_Multi:
    switch (fuel_rate_control_DW.bitsForTID0.is_Multi) {
     case fuel_rate_control_IN_Four:
      if (fuel_rate_control_DW.sfEvent == fuel_rate_control_event_DEC) {
        fuel_rate_control_DW.bitsForTID0.is_Multi = fuel_rate_control_IN_Three;
      }
      break;

     case fuel_rate_control_IN_Three:
      if (fuel_rate_control_DW.sfEvent == fuel_rate_control_event_INC) {
        fuel_rate_control_DW.bitsForTID0.is_Multi = fuel_rate_control_IN_Four;
      } else {
        if (fuel_rate_control_DW.sfEvent == fuel_rate_control_event_DEC) {
          fuel_rate_control_DW.bitsForTID0.is_Multi = fuel_rate_control_IN_Two;
        }
      }
      break;

     case fuel_rate_control_IN_Two:
      if (fuel_rate_control_DW.sfEvent == fuel_rate_control_event_DEC) {
        fuel_rate_control_DW.bitsForTID0.is_Multi =
          fuel_rate_co_IN_NO_ACTIVE_CHILD;
        fuel_rate_control_DW.bitsForTID0.is_Fail =
          fuel_rate_co_IN_NO_ACTIVE_CHILD;
        b_previousEvent = fuel_rate_control_DW.sfEvent;
        fuel_rate_control_DW.sfEvent = fuel_rate_contr_exit_from_Multi;
        if (fuel_rate_control_DW.bitsForTID0.is_active_Fueling_Mode != 0U) {
          fuel_rate_control_Fueling_Mode();
        }

        fuel_rate_control_DW.sfEvent = b_previousEvent;
        fuel_rate_control_DW.bitsForTID0.is_Fail = fuel_rate_control_IN_One;
      } else {
        if (fuel_rate_control_DW.sfEvent == fuel_rate_control_event_INC) {
          fuel_rate_control_DW.bitsForTID0.is_Multi = fuel_rate_control_IN_Three;
        }
      }
      break;

     default:
      /* Unreachable state, for coverage only */
      fuel_rate_control_DW.bitsForTID0.is_Multi =
        fuel_rate_co_IN_NO_ACTIVE_CHILD;
      break;
    }
    break;

   case fuel_rate_control_IN_None:
    if (fuel_rate_control_DW.sfEvent == fuel_rate_control_event_INC) {
      fuel_rate_control_DW.bitsForTID0.is_Fail = fuel_rate_control_IN_One;
    }
    break;

   case fuel_rate_control_IN_One:
    if (fuel_rate_control_DW.sfEvent == fuel_rate_control_event_INC) {
      fuel_rate_control_DW.bitsForTID0.is_Fail = fuel_rate_control_IN_Multi;
      b_previousEvent = fuel_rate_control_DW.sfEvent;
      fuel_rate_control_DW.sfEvent = fuel_rate_contro_entry_to_Multi;
      if (fuel_rate_control_DW.bitsForTID0.is_active_Fueling_Mode != 0U) {
        fuel_rate_control_Fueling_Mode();
      }

      fuel_rate_control_DW.sfEvent = b_previousEvent;
      fuel_rate_control_DW.bitsForTID0.is_Multi = fuel_rate_control_IN_Two;
    } else {
      if (fuel_rate_control_DW.sfEvent == fuel_rate_control_event_DEC) {
        fuel_rate_control_DW.bitsForTID0.is_Fail = fuel_rate_control_IN_None;
      }
    }
    break;

   default:
    /* Unreachable state, for coverage only */
    fuel_rate_control_DW.bitsForTID0.is_Fail = fuel_rate_co_IN_NO_ACTIVE_CHILD;
    break;
  }
}

/* Model step function */
void fuel_rate_control_step(void)
{
  int32_T b_previousEvent;
  real32_T denAccum;
  real32_T rtb_MultiportSwitch;
  real32_T u0;

  /* Outputs for Atomic SubSystem: '<Root>/fuel_rate_control' */
  /* Chart: '<S1>/control_logic' incorporates:
   *  Inport: '<Root>/sensors'
   *  Lookup_n-D: '<S7>/Pressure Estimation'
   *  Lookup_n-D: '<S9>/Throttle Estimation'
   */
  fuel_rate_control_DW.sfEvent = fuel_rate_control_CALL_EVENT;
  if (fuel_rate_control_DW.temporalCounter_i1 < 511U) {
    fuel_rate_control_DW.temporalCounter_i1++;
  }

  if (fuel_rate_control_DW.bitsForTID0.is_active_c1_fuel_rate_control == 0U) {
    fuel_rate_control_DW.bitsForTID0.is_active_c1_fuel_rate_control = 1U;
    fuel_rate_control_DW.bitsForTID0.is_active_O2 = 1U;
    fuel_rate_control_DW.bitsForTID0.is_O2 = fuel_rate_control_IN_A;
    fuel_rate_control_DW.bitsForTID0.is_A = fuel_rate_control_IN_O2_warmup;
    fuel_rate_control_DW.temporalCounter_i1 = 0U;
    fuel_rate_control_DW.bitsForTID0.is_active_Pressure = 1U;
    fuel_rate_control_DW.bitsForTID0.is_Pressure = fuel_rate_control_IN_normal;
    fuel_rate_control_DW.bitsForTID0.is_active_Throttle = 1U;
    fuel_rate_control_DW.bitsForTID0.is_Throttle = fuel_rate_control_IN_normal;
    fuel_rate_control_DW.bitsForTID0.is_active_Speed = 1U;
    fuel_rate_control_DW.bitsForTID0.is_Speed = fuel_rate_control_IN_normal;
    fuel_rate_control_DW.bitsForTID0.is_active_Fail = 1U;
    fuel_rate_control_DW.bitsForTID0.is_Fail = fuel_rate_control_IN_None;
    fuel_rate_control_DW.bitsForTID0.is_active_Fueling_Mode = 1U;
    fuel_rate_control_B.es_o = fuel_rate_control_U.sensors;
    fuel_rate_control_DW.bitsForTID0.is_Fueling_Mode =
      fuel_rate_control_IN_Running;
    fuel_rate_control_DW.bitsForTID0.is_Running =
      fuel_rate_cont_IN_Low_Emissions;
    fuel_rate_control_DW.bitsForTID0.was_Running =
      fuel_rate_cont_IN_Low_Emissions;
    fuel_rate_control_B.fuel_mode = LOW;
    fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
      fuel_rate_control_IN_Warmup;
    fuel_rate_control_DW.bitsForTID0.was_Low_Emissions =
      fuel_rate_control_IN_Warmup;
  } else {
    if ((fuel_rate_control_DW.bitsForTID0.is_active_O2 != 0U) &&
        (fuel_rate_control_DW.bitsForTID0.is_O2 == fuel_rate_control_IN_A)) {
      fuel_rate_control_B.es_o.ego = fuel_rate_control_U.sensors.ego;
      switch (fuel_rate_control_DW.bitsForTID0.is_A) {
       case fuel_rate_control_IN_O2_failure:
        if (fuel_rate_control_U.sensors.ego < 1.2F) {
          fuel_rate_control_DW.bitsForTID0.is_A =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          b_previousEvent = fuel_rate_control_DW.sfEvent;
          fuel_rate_control_DW.sfEvent = fuel_rate_control_event_DEC;
          if (fuel_rate_control_DW.bitsForTID0.is_active_Fail != 0U) {
            fuel_rate_control_Fail();
          }

          fuel_rate_control_DW.sfEvent = b_previousEvent;
          fuel_rate_control_DW.bitsForTID0.is_A = fuel_rate_control_IN_O2_normal;
          fuel_rate_control_B.O2_normal = true;
        }
        break;

       case fuel_rate_control_IN_O2_normal:
        if (fuel_rate_control_U.sensors.ego > 1.2F) {
          fuel_rate_control_B.O2_normal = false;
          fuel_rate_control_DW.bitsForTID0.is_A =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          b_previousEvent = fuel_rate_control_DW.sfEvent;
          fuel_rate_control_DW.sfEvent = fuel_rate_control_event_INC;
          if (fuel_rate_control_DW.bitsForTID0.is_active_Fail != 0U) {
            fuel_rate_control_Fail();
          }

          fuel_rate_control_DW.sfEvent = b_previousEvent;
          fuel_rate_control_DW.bitsForTID0.is_A =
            fuel_rate_control_IN_O2_failure;
        }
        break;

       case fuel_rate_control_IN_O2_warmup:
        if (fuel_rate_control_DW.temporalCounter_i1 >= 480) {
          fuel_rate_control_DW.bitsForTID0.is_A = fuel_rate_control_IN_O2_normal;
          fuel_rate_control_B.O2_normal = true;
        }
        break;

       default:
        /* Unreachable state, for coverage only */
        fuel_rate_control_DW.bitsForTID0.is_A = fuel_rate_co_IN_NO_ACTIVE_CHILD;
        break;
      }
    }

    if (fuel_rate_control_DW.bitsForTID0.is_active_Pressure != 0U) {
      switch (fuel_rate_control_DW.bitsForTID0.is_Pressure) {
       case fuel_rate_control_IN_fail:
        if ((fuel_rate_control_U.sensors.map > 0.05F) &&
            (fuel_rate_control_U.sensors.map < 0.95F)) {
          fuel_rate_control_DW.bitsForTID0.is_Pressure =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          b_previousEvent = fuel_rate_control_DW.sfEvent;
          fuel_rate_control_DW.sfEvent = fuel_rate_control_event_DEC;
          if (fuel_rate_control_DW.bitsForTID0.is_active_Fail != 0U) {
            fuel_rate_control_Fail();
          }

          fuel_rate_control_DW.sfEvent = b_previousEvent;
          fuel_rate_control_DW.bitsForTID0.is_Pressure =
            fuel_rate_control_IN_normal;
        } else {
          /* Outputs for Function Call SubSystem: '<S3>/Pressure.map_estimate' */
          fuel_rate_control_B.es_o.map = look2_iflf_linlca
            (fuel_rate_control_U.sensors.speed,
             fuel_rate_control_U.sensors.throttle,
             fuel_rate_control_ConstP.pooled1, fuel_rate_control_ConstP.pooled2,
             fuel_rate_control_ConstP.PressureEstimation_tableData,
             fuel_rate_control_ConstP.PressureEstimation_maxIndex, 18U);

          /* End of Outputs for SubSystem: '<S3>/Pressure.map_estimate' */
        }
        break;

       case fuel_rate_control_IN_normal:
        if ((fuel_rate_control_U.sensors.map > 0.95F) ||
            (fuel_rate_control_U.sensors.map < 0.05F)) {
          fuel_rate_control_DW.bitsForTID0.is_Pressure =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          b_previousEvent = fuel_rate_control_DW.sfEvent;
          fuel_rate_control_DW.sfEvent = fuel_rate_control_event_INC;
          if (fuel_rate_control_DW.bitsForTID0.is_active_Fail != 0U) {
            fuel_rate_control_Fail();
          }

          fuel_rate_control_DW.sfEvent = b_previousEvent;
          fuel_rate_control_DW.bitsForTID0.is_Pressure =
            fuel_rate_control_IN_fail;
        } else {
          fuel_rate_control_B.es_o.map = fuel_rate_control_U.sensors.map;
        }
        break;

       default:
        /* Unreachable state, for coverage only */
        fuel_rate_control_DW.bitsForTID0.is_Pressure =
          fuel_rate_co_IN_NO_ACTIVE_CHILD;
        break;
      }
    }

    if (fuel_rate_control_DW.bitsForTID0.is_active_Throttle != 0U) {
      switch (fuel_rate_control_DW.bitsForTID0.is_Throttle) {
       case fuel_rate_control_IN_fail:
        if ((fuel_rate_control_U.sensors.throttle > 3.0F) &&
            (fuel_rate_control_U.sensors.throttle < 90.0F)) {
          fuel_rate_control_DW.bitsForTID0.is_Throttle =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          b_previousEvent = fuel_rate_control_DW.sfEvent;
          fuel_rate_control_DW.sfEvent = fuel_rate_control_event_DEC;
          if (fuel_rate_control_DW.bitsForTID0.is_active_Fail != 0U) {
            fuel_rate_control_Fail();
          }

          fuel_rate_control_DW.sfEvent = b_previousEvent;
          fuel_rate_control_DW.bitsForTID0.is_Throttle =
            fuel_rate_control_IN_normal;
        } else {
          /* Outputs for Function Call SubSystem: '<S3>/Throttle.throttle_estimate' */
          fuel_rate_control_B.es_o.throttle = look2_iflf_linlca
            (fuel_rate_control_U.sensors.speed, fuel_rate_control_U.sensors.map,
             fuel_rate_control_ConstP.pooled1, fuel_rate_control_ConstP.pooled3,
             fuel_rate_control_ConstP.ThrottleEstimation_tableData,
             fuel_rate_control_ConstP.pooled8, 18U);

          /* End of Outputs for SubSystem: '<S3>/Throttle.throttle_estimate' */
        }
        break;

       case fuel_rate_control_IN_normal:
        if ((fuel_rate_control_U.sensors.throttle > 90.0F) ||
            (fuel_rate_control_U.sensors.throttle < 3.0F)) {
          fuel_rate_control_DW.bitsForTID0.is_Throttle =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          b_previousEvent = fuel_rate_control_DW.sfEvent;
          fuel_rate_control_DW.sfEvent = fuel_rate_control_event_INC;
          if (fuel_rate_control_DW.bitsForTID0.is_active_Fail != 0U) {
            fuel_rate_control_Fail();
          }

          fuel_rate_control_DW.sfEvent = b_previousEvent;
          fuel_rate_control_DW.bitsForTID0.is_Throttle =
            fuel_rate_control_IN_fail;
        } else {
          fuel_rate_control_B.es_o.throttle =
            fuel_rate_control_U.sensors.throttle;
        }
        break;

       default:
        /* Unreachable state, for coverage only */
        fuel_rate_control_DW.bitsForTID0.is_Throttle =
          fuel_rate_co_IN_NO_ACTIVE_CHILD;
        break;
      }
    }

    if (fuel_rate_control_DW.bitsForTID0.is_active_Speed != 0U) {
      switch (fuel_rate_control_DW.bitsForTID0.is_Speed) {
       case fuel_rate_control_IN_fail:
        if (fuel_rate_control_U.sensors.speed > 0.0F) {
          fuel_rate_control_DW.bitsForTID0.is_Speed =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          b_previousEvent = fuel_rate_control_DW.sfEvent;
          fuel_rate_control_DW.sfEvent = fuel_rate_control_event_DEC;
          if (fuel_rate_control_DW.bitsForTID0.is_active_Fail != 0U) {
            fuel_rate_control_Fail();
          }

          fuel_rate_control_DW.sfEvent = b_previousEvent;
          fuel_rate_control_DW.bitsForTID0.is_Speed =
            fuel_rate_control_IN_normal;
        } else {
          /* Outputs for Function Call SubSystem: '<S3>/Speed.speed_estimate' */
          /* Lookup_n-D: '<S8>/Speed Estimation' */
          u0 = look2_iflf_linlca(fuel_rate_control_U.sensors.throttle,
            fuel_rate_control_U.sensors.map, fuel_rate_control_ConstP.pooled2,
            fuel_rate_control_ConstP.pooled3,
            fuel_rate_control_ConstP.SpeedEstimation_tableData,
            fuel_rate_control_ConstP.SpeedEstimation_maxIndex, 17U);

          /* Saturate: '<S8>/Saturation' */
          if (u0 > 628.0F) {
            fuel_rate_control_B.es_o.speed = 628.0F;
          } else if (u0 < 0.0F) {
            fuel_rate_control_B.es_o.speed = 0.0F;
          } else {
            fuel_rate_control_B.es_o.speed = u0;
          }

          /* End of Saturate: '<S8>/Saturation' */
          /* End of Outputs for SubSystem: '<S3>/Speed.speed_estimate' */
        }
        break;

       case fuel_rate_control_IN_normal:
        if ((fuel_rate_control_U.sensors.speed == 0.0F) &&
            (fuel_rate_control_U.sensors.map < 250.0F)) {
          fuel_rate_control_DW.bitsForTID0.is_Speed =
            fuel_rate_co_IN_NO_ACTIVE_CHILD;
          b_previousEvent = fuel_rate_control_DW.sfEvent;
          fuel_rate_control_DW.sfEvent = fuel_rate_control_event_INC;
          if (fuel_rate_control_DW.bitsForTID0.is_active_Fail != 0U) {
            fuel_rate_control_Fail();
          }

          fuel_rate_control_DW.sfEvent = b_previousEvent;
          fuel_rate_control_DW.bitsForTID0.is_Speed = fuel_rate_control_IN_fail;
        } else {
          fuel_rate_control_B.es_o.speed = fuel_rate_control_U.sensors.speed;
        }
        break;

       default:
        /* Unreachable state, for coverage only */
        fuel_rate_control_DW.bitsForTID0.is_Speed =
          fuel_rate_co_IN_NO_ACTIVE_CHILD;
        break;
      }
    }

    if (fuel_rate_control_DW.bitsForTID0.is_active_Fail != 0U) {
      fuel_rate_control_Fail();
    }

    if (fuel_rate_control_DW.bitsForTID0.is_active_Fueling_Mode != 0U) {
      fuel_rate_control_Fueling_Mode();
    }
  }

  /* End of Chart: '<S1>/control_logic' */

  /* DiscreteFilter: '<S2>/Throttle Transient' */
  u0 = fuel_rate_control_B.es_o.throttle - -0.8F *
    fuel_rate_control_DW.ThrottleTransient_states;

  /* MultiPortSwitch: '<S10>/Multiport Switch' incorporates:
   *  Constant: '<S10>/normal'
   *  Constant: '<S10>/rich'
   *  Constant: '<S10>/shutdown'
   */
  switch (fuel_rate_control_B.fuel_mode) {
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
  switch (fuel_rate_control_B.fuel_mode) {
   case LOW:
    /* Outputs for IfAction SubSystem: '<S11>/low_mode' incorporates:
     *  ActionPort: '<S13>/Action Port'
     */
    /* DiscreteFilter: '<S13>/Discrete Filter' incorporates:
     *  DiscreteIntegrator: '<S2>/Discrete Integrator'
     */
    denAccum = fuel_rate_control_DW.DiscreteIntegrator_DSTATE - -0.7408F *
      fuel_rate_control_DW.DiscreteFilter_states_i;

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
    fuel_rate_control_Y.fuel_rate = ((0.01F * u0 + -0.01F *
      fuel_rate_control_DW.ThrottleTransient_states) +
      fuel_rate_control_B.es_o.speed * look2_iflf_linlca
      (fuel_rate_control_B.es_o.speed, fuel_rate_control_B.es_o.map,
       fuel_rate_control_ConstP.pooled1, fuel_rate_control_ConstP.pooled3,
       fuel_rate_control_ConstP.PumpingConstant_tableData,
       fuel_rate_control_ConstP.pooled8, 18U) * fuel_rate_control_B.es_o.map) *
      rtb_MultiportSwitch + (8.7696F * denAccum + -8.5104F *
      fuel_rate_control_DW.DiscreteFilter_states_i);

    /* Update for DiscreteFilter: '<S13>/Discrete Filter' */
    fuel_rate_control_DW.DiscreteFilter_states_i = denAccum;

    /* End of Outputs for SubSystem: '<S11>/low_mode' */
    break;

   case RICH:
    /* Outputs for IfAction SubSystem: '<S11>/rich_mode' incorporates:
     *  ActionPort: '<S14>/Action Port'
     */
    /* Outport: '<Root>/fuel_rate' incorporates:
     *  DiscreteFilter: '<S14>/Discrete Filter'
     */
    fuel_rate_control_Y.fuel_rate = 0.2592F *
      fuel_rate_control_DW.DiscreteFilter_states;

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
    fuel_rate_control_DW.DiscreteFilter_states = (((0.01F * u0 + -0.01F *
      fuel_rate_control_DW.ThrottleTransient_states) +
      fuel_rate_control_B.es_o.speed * look2_iflf_linlca
      (fuel_rate_control_B.es_o.speed, fuel_rate_control_B.es_o.map,
       fuel_rate_control_ConstP.pooled1, fuel_rate_control_ConstP.pooled3,
       fuel_rate_control_ConstP.PumpingConstant_tableData,
       fuel_rate_control_ConstP.pooled8, 18U) * fuel_rate_control_B.es_o.map) *
      rtb_MultiportSwitch + fuel_rate_control_DW.DiscreteIntegrator_DSTATE) -
      -0.7408F * fuel_rate_control_DW.DiscreteFilter_states;

    /* End of Outputs for SubSystem: '<S11>/rich_mode' */
    break;

   default:
    /* Outputs for IfAction SubSystem: '<S11>/disabled_mode' incorporates:
     *  ActionPort: '<S12>/Action Port'
     */
    /* Outport: '<Root>/fuel_rate' incorporates:
     *  Constant: '<S12>/shutoff'
     */
    fuel_rate_control_Y.fuel_rate = 0.0F;

    /* End of Outputs for SubSystem: '<S11>/disabled_mode' */
    break;
  }

  /* End of SwitchCase: '<S11>/Switch Case' */

  /* Update for DiscreteFilter: '<S2>/Throttle Transient' */
  fuel_rate_control_DW.ThrottleTransient_states = u0;

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
  if (fuel_rate_control_B.O2_normal && (fuel_rate_control_B.fuel_mode == LOW)) {
    u0 = ((real32_T)(fuel_rate_control_B.es_o.ego <= 0.5F) - 0.5F) *
      look2_iflf_linlca(fuel_rate_control_B.es_o.speed,
                        fuel_rate_control_B.es_o.map,
                        fuel_rate_control_ConstP.RampRateKi_bp01Data,
                        fuel_rate_control_ConstP.RampRateKi_bp02Data,
                        fuel_rate_control_ConstP.RampRateKi_tableData,
                        fuel_rate_control_ConstP.RampRateKi_maxIndex, 6U);
  } else {
    u0 = 0.0F;
  }

  /* End of Switch: '<S2>/hold integrator' */

  /* Update for DiscreteIntegrator: '<S2>/Discrete Integrator' */
  fuel_rate_control_DW.DiscreteIntegrator_DSTATE += 0.01F * u0;

  /* End of Outputs for SubSystem: '<Root>/fuel_rate_control' */
}

/* Model initialize function */
void fuel_rate_control_initialize(void)
{
  /* Registration code */

  /* initialize error status */
  rtmSetErrorStatus(fuel_rate_control_M, (NULL));

  /* block I/O */
  (void) memset(((void *) &fuel_rate_control_B), 0,
                sizeof(B_fuel_rate_control_T));

  {
    fuel_rate_control_B.fuel_mode = LOW;
  }

  /* states (dwork) */
  (void) memset((void *)&fuel_rate_control_DW, 0,
                sizeof(DW_fuel_rate_control_T));

  /* external inputs */
  fuel_rate_control_U.sensors = fuel_rate_control_rtZEngSensors;

  /* external outputs */
  fuel_rate_control_Y.fuel_rate = 0.0F;

  /* SystemInitialize for Atomic SubSystem: '<Root>/fuel_rate_control' */
  /* InitializeConditions for DiscreteFilter: '<S2>/Throttle Transient' */
  fuel_rate_control_DW.ThrottleTransient_states = 0.0F;

  /* InitializeConditions for DiscreteIntegrator: '<S2>/Discrete Integrator' */
  fuel_rate_control_DW.DiscreteIntegrator_DSTATE = 0.0F;

  /* SystemInitialize for Chart: '<S1>/control_logic' */
  fuel_rate_control_DW.sfEvent = fuel_rate_control_CALL_EVENT;
  fuel_rate_control_DW.bitsForTID0.is_active_Fail = 0U;
  fuel_rate_control_DW.bitsForTID0.is_Fail = fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_Multi = fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_active_Fueling_Mode = 0U;
  fuel_rate_control_DW.bitsForTID0.is_Fueling_Mode =
    fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_Fuel_Disabled =
    fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_Running = fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.was_Running = fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_Low_Emissions =
    fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.was_Low_Emissions =
    fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_Rich_Mixture =
    fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_active_O2 = 0U;
  fuel_rate_control_DW.bitsForTID0.is_O2 = fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_A = fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.temporalCounter_i1 = 0U;
  fuel_rate_control_DW.bitsForTID0.is_active_Pressure = 0U;
  fuel_rate_control_DW.bitsForTID0.is_Pressure = fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_active_Speed = 0U;
  fuel_rate_control_DW.bitsForTID0.is_Speed = fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_active_Throttle = 0U;
  fuel_rate_control_DW.bitsForTID0.is_Throttle = fuel_rate_co_IN_NO_ACTIVE_CHILD;
  fuel_rate_control_DW.bitsForTID0.is_active_c1_fuel_rate_control = 0U;
  fuel_rate_control_B.es_o.throttle = 0.0F;
  fuel_rate_control_B.es_o.speed = 0.0F;
  fuel_rate_control_B.es_o.ego = 0.0F;
  fuel_rate_control_B.es_o.map = 0.0F;
  fuel_rate_control_B.O2_normal = false;
  fuel_rate_control_B.fuel_mode = LOW;

  /* SystemInitialize for IfAction SubSystem: '<S11>/low_mode' */
  /* InitializeConditions for DiscreteFilter: '<S13>/Discrete Filter' */
  fuel_rate_control_DW.DiscreteFilter_states_i = 0.0F;

  /* End of SystemInitialize for SubSystem: '<S11>/low_mode' */

  /* SystemInitialize for IfAction SubSystem: '<S11>/rich_mode' */
  /* InitializeConditions for DiscreteFilter: '<S14>/Discrete Filter' */
  fuel_rate_control_DW.DiscreteFilter_states = 0.0F;

  /* End of SystemInitialize for SubSystem: '<S11>/rich_mode' */
  /* End of SystemInitialize for SubSystem: '<Root>/fuel_rate_control' */
}

/* Model terminate function */
void fuel_rate_control_terminate(void)
{
  /* (no terminate code required) */
}
