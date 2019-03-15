state("FEAR")
{
	bool bLoading : 0x173DB0;
	bool bPause : 0x16CCE8; 
	byte bCinematics : 0x00170CB4, 0x4, 0xAC, 0x20, 0x174, 0x678;
	byte bSaveRemoval : 0x00015DCC, 0x288;
	string16 mission : 0x16C045
}

init
{
	vars.split = 0;
	vars.oMission = 0;
	vars.cMission = 0;

}

update
{

}

startup
{
settings.Add("autotimer",true,"AutoStart Timer");
settings.Add("autosplitter",true,"Autosplitter");
settings.Add("loadremover",true,"Load Remover");
settings.Add("pausetimer",false,"Pause Remover");
settings.Add("cinematicsremover",false,"Cinematics Remover");
settings.Add("checkpointremover",false,"Experimental QuickSave/Checkpoint Remover");

}

start
{ 

	if (settings["autotimer"]) {
		if (current.mission == "Intro.World00p") 
		{
			vars.split = vars.split + 1;
		return true;
		}
	}
	
}

split
{
//print ("old: (" + vars.oMission + ") - new: (" + vars.cMission + ")");

	if (old.mission.Length != 0)
	vars.oMission = old.mission;

	if (current.mission.Length != 0)
	vars.cMission = current.mission;

	if (settings["autosplitter"]) 
	{
		if (vars.oMission != vars.cMission)
			return true;
	}
}

reset
{
//	if (settings["autotimer"]) {
//		if (current.mission == 0)
//			return true;
//	}
}
isLoading
{
	if (settings["pausetimer"]) 
	{
		if (current.bPause == true) 
			return true;
	}

	if (settings["cinematicsremover"]) 
	{
		if (current.bCinematics == 1)
			return true;

	}
	if (settings["loadremover"]) {
		if (current.bLoading == true)
			return true;
	}
	if (settings["checkpointremover"]) {
	if (current.bSaveRemoval == 1)
	{
	print ("SaveRemoved");
		return true;
	}
	}
	
	return false;
}

exit
{
	// timer.IsGameTimePaused = true;
}