if (fadetype == 0)
{
    TweenFire(id, EaseOutCirc, 0, 0, 0, fadeamt, "scale", 75, 0)
    alarm[0] = (fadeamt + 30)
}
else if (fadetype == 1)
{
    TweenFire(id, EaseOutCirc, 0, 0, 0, fadeamt, "scale", 0, 75)
    alarm[0] = fadeamt
    if instance_exists(PLAYER1)
        player_freeze()
}
