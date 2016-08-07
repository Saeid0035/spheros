﻿local function tosticker(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/sstickers/'..msg.from.id..'.webp'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    --send_document(get_receiver(msg), file, ok_cb, false)
    redis:del("photo:setsticker")
	return reply_msg(msg.id, 'Your sticker was saved\nYour sticker Show to plugins : info/me .', ok_cb, false)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'دوباره امتحان کنید', ok_cb, false)
  end
end
local function tosticker2(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/sstickers/'..msg.from.id..'.webp'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    --send_document(get_receiver(msg), file, ok_cb, false)
    redis:del("photo:setsticker")
	return reply_msg(msg.reply_id, 'Your sticker was saved\nYour sticker Show to plugins : info/me.', ok_cb, false)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'tryagain please', ok_cb, false)
  end
end

local function run(msg,matches)
    local receiver = get_receiver(msg)
    local group = msg.to.id
	if not msg.reply_id then
    if msg.media then
       if msg.media.type == 'photo' and redis:get("photo:setsticker") then
        if redis:get("photo:setsticker") == 'waiting' then
          load_photo(msg.id, tosticker, msg)
        end
       end
    end
    if matches[1] == "setsticker" then
     redis:set("photo:setsticker", "waiting")
     return reply_msg(msg.id, 'please send your photo now', ok_cb, false)
    end
	end
if msg.reply_id then
	 if msg.to.type == 'photo' and redis:get("photo:sticker") then
        if redis:set("photo:sticker", "waiting") then
        end
       end
    if matches[1]:lower() == "setsticker" then
     redis:get("photo:sticker")  
     load_photo(msg.reply_id, tosticker2, msg)
    end
	end
	local files = './data/sstickers/'..msg.from.id..'.webp'
	if matches[1]:lower() == 'mysticker' or 'info' or 'me' then
	if not files then
	return "No sticker available \ntype (setsticker) for set your sticker"
	else
	return reply_document(msg.id, files, ok_cb, false) --send_document(get_receiver(msg), files, ok_cb, false)
end
end
end
return {
  patterns = {
 "^(setsticker)$",
 "^(mysticker)$",
 "^([Ii]nfo)$",
 "^[!/#](me)$",
 "%[(photo)%]",
  },
  run = run,
}
