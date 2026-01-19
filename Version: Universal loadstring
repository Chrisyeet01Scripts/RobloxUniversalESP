local function httpGet(url)
    local req =
        (syn and syn.request)
        or (http and http.request)
        or http_request
        or request
        or (fluxus and fluxus.request)

    if req then
        local res = req({
            Url = url,
            Method = "GET"
        })
        return res.Body
    end

    return game:HttpGet(url)
end

local source = httpGet("https://raw.githubusercontent.com/Chrisyeet01Scripts/RobloxUniversalESP/refs/heads/main/Obfuscated%20Version")
loadstring(source)()
