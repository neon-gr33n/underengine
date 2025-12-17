if (instance_exists(__info)) instance_destroy(__info);
if (instance_exists(__invmain)) instance_destroy(__invmain);
if (instance_exists(__invarm)) instance_destroy(__invarm);
if (instance_exists(__invkey)) instance_destroy(__invkey);
if (instance_exists(__invwep)) instance_destroy(__invwep);
if (instance_exists(__stat)) instance_destroy(__stat);
if (instance_exists(__stat2)) instance_destroy(__stat2);
if (instance_exists(__contacts)) instance_destroy(__contacts);
if (instance_exists(__contacts_call_choices)) instance_destroy(__contacts_call_choices);
player_unfreeze()