function CodeMetrics() {
	 this.metricsArray = {};
	 this.metricsArray.var = new Array();
	 this.metricsArray.fcn = new Array();
	 this.metricsArray.var["rtDW"] = {file: "C:\\Users\\user\\Documents\\MATLAB\\Examples\\R2019a\\simulinkcoder\\FuelRateControlSystemExample\\fuel_rate_control_ert_rtw\\fuel_rate_control.c",
	size: 43};
	 this.metricsArray.var["rtM_"] = {file: "C:\\Users\\user\\Documents\\MATLAB\\Examples\\R2019a\\simulinkcoder\\FuelRateControlSystemExample\\fuel_rate_control_ert_rtw\\fuel_rate_control.c",
	size: 8};
	 this.metricsArray.var["rtU"] = {file: "C:\\Users\\user\\Documents\\MATLAB\\Examples\\R2019a\\simulinkcoder\\FuelRateControlSystemExample\\fuel_rate_control_ert_rtw\\fuel_rate_control.c",
	size: 16};
	 this.metricsArray.var["rtY"] = {file: "C:\\Users\\user\\Documents\\MATLAB\\Examples\\R2019a\\simulinkcoder\\FuelRateControlSystemExample\\fuel_rate_control_ert_rtw\\fuel_rate_control.c",
	size: 4};
	 this.metricsArray.fcn["fuel_rate_control.c:Fail"] = {file: "C:\\Users\\user\\Documents\\MATLAB\\Examples\\R2019a\\simulinkcoder\\FuelRateControlSystemExample\\fuel_rate_control_ert_rtw\\fuel_rate_control.c",
	stack: 4,
	stackTotal: 4};
	 this.metricsArray.fcn["fuel_rate_control.c:Fueling_Mode"] = {file: "C:\\Users\\user\\Documents\\MATLAB\\Examples\\R2019a\\simulinkcoder\\FuelRateControlSystemExample\\fuel_rate_control_ert_rtw\\fuel_rate_control.c",
	stack: 0,
	stackTotal: 0};
	 this.metricsArray.fcn["fuel_rate_control.c:look2_iflf_linlca"] = {file: "C:\\Users\\user\\Documents\\MATLAB\\Examples\\R2019a\\simulinkcoder\\FuelRateControlSystemExample\\fuel_rate_control_ert_rtw\\fuel_rate_control.c",
	stack: 36,
	stackTotal: 36};
	 this.metricsArray.fcn["fuel_rate_control_initialize"] = {file: "C:\\Users\\user\\Documents\\MATLAB\\Examples\\R2019a\\simulinkcoder\\FuelRateControlSystemExample\\fuel_rate_control_ert_rtw\\fuel_rate_control.c",
	stack: 0,
	stackTotal: 0};
	 this.metricsArray.fcn["fuel_rate_control_step"] = {file: "C:\\Users\\user\\Documents\\MATLAB\\Examples\\R2019a\\simulinkcoder\\FuelRateControlSystemExample\\fuel_rate_control_ert_rtw\\fuel_rate_control.c",
	stack: 16,
	stackTotal: 52};
	 this.getMetrics = function(token) { 
		 var data;
		 data = this.metricsArray.var[token];
		 if (!data) {
			 data = this.metricsArray.fcn[token];
			 if (data) data.type = "fcn";
		 } else { 
			 data.type = "var";
		 }
	 return data; }; 
	 this.codeMetricsSummary = '<a href="fuel_rate_control_metrics.html">Global Memory: 71(bytes) Maximum Stack: 36(bytes)</a>';
	}
CodeMetrics.instance = new CodeMetrics();
