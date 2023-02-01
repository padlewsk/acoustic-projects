#include "slrtappmapping.h"
#include "./maps/ms_param_SG.map"



const AppMapInfo appInfo[] = 
{
	{ /* Idx 0, <ms_param_SG> */
		{ /* SignalMapInfo */
			ms_param_SG_BIOMAP,
			ms_param_SG_LBLMAP,
			ms_param_SG_SIDMAP,
			ms_param_SG_SBIO,
			ms_param_SG_SLBL,
			{0,38},
			39,
		},
		{ /* ParamMapInfo */
			ms_param_SG_PTIDSMAP,
			ms_param_SG_PTNAMESMAP,
			ms_param_SG_SPTMAP,
			{0,14},
			15,
		},
		"ms_param_SG",
		"",
		"ms_param_SG",
		4,
		ms_param_SG_dtmap,
	},
};
int getNumRef(void){
	 return(sizeof(appInfo) / sizeof(AppMapInfo));
}