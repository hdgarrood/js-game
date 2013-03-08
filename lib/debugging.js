function now() { return new Date().getTime() }
function sleep(ms) {
    var unixtime = now(),
        target = unixtime + ms;
    while(now() < target) {};
    return ms;
}
