-- 让某个输出的 noctalia 壁纸层重新接管（清掉 mpvpaper 插件的 externally-managed 标记），
-- 并把它设成指定图片。用于视频壁纸时让 overview 走静态壁纸路线。
function onIpc(event, payload)
  if event ~= "frame" then
    return
  end
  if type(payload) ~= "string" or payload == "" then
    noctalia.log("video-frame: missing path")
    return
  end
  for _, output in ipairs(noctalia.outputs()) do
    noctalia.setWallpaperEnabled(output.name, true)
    noctalia.setWallpaper(output.name, payload)
  end
  noctalia.log("video-frame: wallpaper layer -> " .. payload)
end
