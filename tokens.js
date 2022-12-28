.pragma library

function tokenify(url) {
    let s;
    [s, url] = readScheme(url);
    let tokens = [];
    while (url) {
        let token;
        [token, url] = readToken(url);
        tokens.push(token);
    }
    return [s,tokens];
}

function readScheme(url) {
    let i = 0;
    let counter = 0;
    let scheme = [];
    for (let c of url) {
        i++;
        scheme.push(c);
        if (c === "/")
            counter++;
        if (counter === 2)
            break;
    }
    if (counter !== 2)
        throw new Error("Invalid url. No Scheme found");
    return [scheme.join(""), url.slice(i, url.length)];
}

function readToken(url) {
    let i = 0;
    let token = [];
    let tokenStarted = false;
    for (let c of url) {
        i++;
        if ((c === "/") && !tokenStarted) {
            tokenStarted = true;
            continue;
        }
        else if ((c === "/") && tokenStarted) {
            i--;
            break;
        }
        token.push(c);
    }
    return [token.join(""), url.slice(i, url.length)];
}
