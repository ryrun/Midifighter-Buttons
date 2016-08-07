function set_midifighter_buttons()
  local outs = renoise.Midi.available_output_devices()
  local instrIndex = renoise.song().selected_instrument_index
  local instr = renoise.song().instruments[instrIndex]
  local samplemappings = instr.sample_mappings[renoise.Instrument.LAYER_NOTE_ON]
  local colortable = {79,61,109,30 ,84,80,74}
  
  local out = nil
  local noteon = 0x90
  local noteoff = 0x80
  
  for i=1, #outs do
    if string.find( outs[i], "Midi Fighter 3D") then
      out = renoise.Midi.create_output_device( outs[i] )
      break;
    end
  end
  
  if out then
    -- clear all buttons
    for i=1, 127 do
      out:send {noteoff+2, i, 0x0}
    end
    
    --step through each sample
    for i=1, table.getn(samplemappings) do
      if samplemappings[i].base_note>23 and samplemappings[i].base_note<87 then
        if samplemappings[i].sample.mute_group>0 then
          out:send {
            noteon+2, 
            samplemappings[i].base_note-((renoise.song().transport.octave-4)*12),
            colortable[samplemappings[i].sample.mute_group]
          }
         out:send {
            noteon+3, 
            samplemappings[i].base_note-((renoise.song().transport.octave-4)*12),
            33
         }
        end
      end
    end
  end
end

renoise.tool():add_menu_entry {
  name = "--- Main Menu:Tools:Set midifighter button leds ...",
  invoke = function() set_midifighter_buttons() end
}

renoise.tool():add_keybinding {
   name = "Global:Midifighter:Set button leds ...",
   invoke = function() set_midifighter_buttons() end
}
