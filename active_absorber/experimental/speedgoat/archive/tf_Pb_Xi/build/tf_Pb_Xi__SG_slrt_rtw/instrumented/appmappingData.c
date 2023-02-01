#include "slrtappmapping.h"
#include "./maps/tf_Pb_Xi__SG.map"



const AppMapInfo appInfo[] = 
{
	{ /* Idx 0, <tf_Pb_Xi__SG> */
		{ /* SignalMapInfo */
			tf_Pb_Xi__SG_BIOMAP,
			tf_Pb_Xi__SG_LBLMAP,
			tf_Pb_Xi__SG_SIDMAP,
			tf_Pb_Xi__SG_SBIO,
			tf_Pb_Xi__SG_SLBL,
			{0,38},
			39,
		},
		{ /* ParamMapInfo */
			tf_Pb_Xi__SG_PTIDSMAP,
			tf_Pb_Xi__SG_PTNAMESMAP,
			tf_Pb_Xi__SG_SPTMAP,
			{0,15},
			16,
		},
		"tf_Pb_Xi__SG",
		"",
		"tf_Pb_Xi__SG",
		4,
		tf_Pb_Xi__SG_dtmap,
	},
};
int getNumRef(void){
	 return(sizeof(appInfo) / sizeof(AppMapInfo));
}