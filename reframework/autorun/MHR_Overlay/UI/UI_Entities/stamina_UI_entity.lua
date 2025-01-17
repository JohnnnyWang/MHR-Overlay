local stamina_UI_entity = {};
local table_helpers;
local drawing;
local language;
local config;

function stamina_UI_entity.new(visibility, bar, text_label, value_label, percentage_label)
	local entity = {};

	local global_scale_modifier = config.current_config.global_settings.modifiers.global_scale_modifier;

	entity.visibility = visibility;
	entity.bar = table_helpers.deep_copy(bar);
	entity.text_label = table_helpers.deep_copy(text_label);
	entity.value_label = table_helpers.deep_copy(value_label);
	entity.percentage_label = table_helpers.deep_copy(percentage_label);

	entity.bar.offset.x = entity.bar.offset.x * global_scale_modifier;
	entity.bar.offset.y = entity.bar.offset.y * global_scale_modifier;
	entity.bar.size.width = entity.bar.size.width * global_scale_modifier;
	entity.bar.size.height = entity.bar.size.height * global_scale_modifier;

	entity.text_label.offset.x = entity.text_label.offset.x * global_scale_modifier;
	entity.text_label.offset.y = entity.text_label.offset.y * global_scale_modifier;

	entity.value_label.offset.x = entity.value_label.offset.x * global_scale_modifier;
	entity.value_label.offset.y = entity.value_label.offset.y * global_scale_modifier;

	entity.percentage_label.offset.x = entity.percentage_label.offset.x * global_scale_modifier;
	entity.percentage_label.offset.y = entity.percentage_label.offset.y * global_scale_modifier;

	return entity;
end

function stamina_UI_entity.draw(monster, stamina_UI, position_on_screen, opacity_scale)
	if not stamina_UI.visibility then
		return;
	end

	drawing.draw_bar(stamina_UI.bar, position_on_screen, opacity_scale, monster.stamina_percentage);

	drawing.draw_label(stamina_UI.text_label, position_on_screen, opacity_scale, language.current_language.UI.stamina);
	drawing.draw_label(stamina_UI.value_label, position_on_screen, opacity_scale, monster.stamina, monster.max_stamina);
	drawing.draw_label(stamina_UI.percentage_label, position_on_screen, opacity_scale, 100 * monster.stamina_percentage);
end

function stamina_UI_entity.init_module()
	table_helpers = require("MHR_Overlay.Misc.table_helpers");
	drawing = require("MHR_Overlay.UI.drawing");
	language = require("MHR_Overlay.Misc.language");
	config = require("MHR_Overlay.Misc.config");
end

return stamina_UI_entity;