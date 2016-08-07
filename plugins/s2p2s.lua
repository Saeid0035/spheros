local function toimage(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/photos/'..msg.from.id..'.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_photo(get_receiver(msg), file, ok_cb, false)
    redis:del("sticker:photo")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
local function run(msg,matches)
    local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
       if msg.to.type == 'document' and redis:get("sticker:photo") then
        if redis:set("sticker:photo", "waiting") then
        end
       end
    
      if matches[1]:lower() == "photo" then
     redis:get("sticker:photo")
    send_large_msg(receiver, 'Done ! Your Photo👇', ok_cb, false)
        load_document(msg.reply_id, toimage, msg)
    end
local function tosticker(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/photos/'..msg.from.id..'.webp'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_document(get_receiver(msg), file, ok_cb, false)
    redis:del("photo:sticker")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
local function run(msg,matches)
    local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
       if msg.to.type == 'photo' and redis:get("photo:sticker") then
        if redis:set("photo:sticker", "waiting") then
        end
       end
    
      if matches[1]:lower() == "sticker" then
     redis:get("photo:sticker")  
    send_large_msg(receiver, 'Done ! Your Sticker👇', ok_cb, false)
        load_photo(msg.reply_id, tosticker, msg)
    end
end
end
return {
  patterns = {
 "^[!/](photo)$",
 "^([Ss]ticker)$",
 "^[!/](sticker)$",
 "^([Pp]hoto)$"
  },
  run = run
  }
