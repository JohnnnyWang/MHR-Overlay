local customization_menu = {};

local table_helpers;
local config;
local screen;
local player;
local large_monster;
local small_monster;
local language;
local part_names;

customization_menu.font = nil;
customization_menu.font_range = { 0x1, 0xFFFF, 0 };

customization_menu.is_opened = false;
customization_menu.status = "OK";

customization_menu.window_position = Vector2f.new(480, 200);
customization_menu.window_pivot = Vector2f.new(0, 0);
customization_menu.window_size = Vector2f.new(720, 720);
customization_menu.window_flags = 0x10120;

customization_menu.color_picker_flags = 327680;

customization_menu.selected_language_index = 1;

customization_menu.displayed_orientation_types = {};
customization_menu.displayed_anchor_types = {};

customization_menu.displayed_monster_UI_sorting_types = {};
customization_menu.displayed_large_monster_UI_parts_sorting_types = {};

customization_menu.displayed_damage_meter_UI_highlighted_bar_types = {};
customization_menu.displayed_damage_meter_UI_damage_bar_relative_types = {};
customization_menu.displayed_damage_meter_UI_my_damage_bar_location_types = {};
customization_menu.displayed_damage_meter_UI_sorting_types = {};

customization_menu.orientation_types = {};
customization_menu.anchor_types = {};

customization_menu.monster_UI_sorting_types = {};
customization_menu.large_monster_UI_parts_sorting_types = {};

customization_menu.damage_meter_UI_highlighted_bar_types = {};
customization_menu.damage_meter_UI_damage_bar_relative_types = {};
customization_menu.damage_meter_UI_my_damage_bar_location_types = {};
customization_menu.damage_meter_UI_sorting_types = {};

customization_menu.fonts = {"Arial", "Arial Black", "Bahnschrift", "Calibri", "Cambria", "Cambria Math", "Candara",
                            "Comic Sans MS", "Consolas", "Constantia", "Corbel", "Courier New", "Ebrima",
                            "Franklin Gothic Medium", "Gabriola", "Gadugi", "Georgia", "HoloLens MDL2 Assets", "Impact",
                            "Ink Free", "Javanese Text", "Leelawadee UI", "Lucida Console", "Lucida Sans Unicode",
                            "Malgun Gothic", "Marlett", "Microsoft Himalaya", "Microsoft JhengHei",
                            "Microsoft New Tai Lue", "Microsoft PhagsPa", "Microsoft Sans Serif", "Microsoft Tai Le",
                            "Microsoft YaHei", "Microsoft Yi Baiti", "MingLiU-ExtB", "Mongolian Baiti", "MS Gothic",
                            "MV Boli", "Myanmar Text", "Nirmala UI", "Palatino Linotype", "Segoe MDL2 Assets",
                            "Segoe Print", "Segoe Script", "Segoe UI", "Segoe UI Historic", "Segoe UI Emoji",
                            "Segoe UI Symbol", "SimSun", "Sitka", "Sylfaen", "Symbol", "Tahoma", "Times New Roman",
                            "Trebuchet MS", "Verdana", "Webdings", "Wingdings", "Yu Gothic"};

customization_menu.small_monster_UI_orientation_index = 1;
customization_menu.small_monster_UI_sorting_type_index = 1;

customization_menu.large_monster_UI_orientation_index = 1;
customization_menu.large_monster_UI_sorting_type_index = 1;

customization_menu.large_monster_dynamic_UI_parts_sorting_type_index = 1;
customization_menu.large_monster_static_UI_parts_sorting_type_index = 1;

customization_menu.damage_meter_UI_orientation_index = 1;
customization_menu.damage_meter_UI_sorting_type_index = 1;
customization_menu.damage_meter_UI_highlighted_bar_index = 1;
customization_menu.damage_meter_UI_damage_bar_relative_index = 1;
customization_menu.damage_meter_UI_my_damage_bar_location_index = 1;

customization_menu.small_monster_UI_anchor_index = 1;
customization_menu.large_monster_UI_anchor_index = 1;
customization_menu.time_UI_anchor_index = 1;
customization_menu.damage_meter_UI_anchor_index = 1;

customization_menu.selected_UI_font_index = 9;

function customization_menu.init()
	customization_menu.font = imgui.load_font(language.current_language.font_name, config.current_config.global_settings.menu_font.size, customization_menu.font_range);

	customization_menu.selected_language_index = table_helpers.find_index(language.language_names, config.current_config.global_settings.language, false);

	customization_menu.displayed_orientation_types = {language.current_language.customization_menu.horizontal, language.current_language.customization_menu.vertical};
	customization_menu.displayed_anchor_types = {language.current_language.customization_menu.top_left, language.current_language.customization_menu.top_right, language.current_language.customization_menu.bottom_left, language.current_language.customization_menu.bottom_right};
	
	customization_menu.displayed_monster_UI_sorting_types = {language.current_language.customization_menu.normal, language.current_language.customization_menu.health, language.current_language.customization_menu.health_percentage, language.current_language.customization_menu.distance};
	customization_menu.displayed_large_monster_UI_parts_sorting_types = {language.current_language.customization_menu.normal, language.current_language.customization_menu.health, language.current_language.customization_menu.health_percentage};
	
	customization_menu.displayed_damage_meter_UI_highlighted_bar_types = {language.current_language.customization_menu.me, language.current_language.customization_menu.top_damage, language.current_language.customization_menu.none};
	customization_menu.displayed_damage_meter_UI_damage_bar_relative_types = {language.current_language.customization_menu.total_damage, language.current_language.customization_menu.top_damage};
	customization_menu.displayed_damage_meter_UI_my_damage_bar_location_types = {language.current_language.customization_menu.normal, language.current_language.customization_menu.first, language.current_language.customization_menu.last};
	customization_menu.displayed_damage_meter_UI_sorting_types = {language.current_language.customization_menu.normal, language.current_language.customization_menu.damage};




	customization_menu.orientation_types = {language.default_language.customization_menu.horizontal, language.default_language.customization_menu.vertical};
	customization_menu.anchor_types = {language.default_language.customization_menu.top_left, language.default_language.customization_menu.top_right, language.default_language.customization_menu.bottom_left, language.default_language.customization_menu.bottom_right};
	
	customization_menu.monster_UI_sorting_types = {language.default_language.customization_menu.normal, language.default_language.customization_menu.health, language.default_language.customization_menu.health_percentage, language.default_language.customization_menu.distance};
	customization_menu.large_monster_UI_parts_sorting_types = {language.default_language.customization_menu.normal, language.default_language.customization_menu.health, language.default_language.customization_menu.health_percentage};
	
	customization_menu.damage_meter_UI_highlighted_bar_types = {language.default_language.customization_menu.me, language.default_language.customization_menu.top_damage, language.default_language.customization_menu.none};
	customization_menu.damage_meter_UI_damage_bar_relative_types = {language.default_language.customization_menu.total_damage, language.default_language.customization_menu.top_damage};
	customization_menu.damage_meter_UI_my_damage_bar_location_types = {language.default_language.customization_menu.normal, language.default_language.customization_menu.first, language.default_language.customization_menu.last};
	customization_menu.damage_meter_UI_sorting_types = {language.default_language.customization_menu.normal, language.default_language.customization_menu.damage};



	customization_menu.large_monster_UI_orientation_index = table_helpers.find_index(customization_menu.orientation_types,
		config.current_config.large_monster_UI.static.settings.orientation, false);

	customization_menu.large_monster_UI_sorting_type_index = table_helpers.find_index(
		customization_menu.monster_UI_sorting_types, config.current_config.large_monster_UI.static.sorting.type, false);

	customization_menu.large_monster_dynamic_UI_parts_sorting_type_index = table_helpers.find_index(
		customization_menu.large_monster_UI_parts_sorting_types,
		config.current_config.large_monster_UI.dynamic.parts.sorting.type, false);

	customization_menu.large_monster_static_UI_parts_sorting_type_index = table_helpers.find_index(
		customization_menu.large_monster_UI_parts_sorting_types,
		config.current_config.large_monster_UI.static.parts.sorting.type, false);

	customization_menu.damage_meter_UI_orientation_index = table_helpers.find_index(customization_menu.orientation_types,
		config.current_config.damage_meter_UI.settings.orientation, false);

	customization_menu.damage_meter_UI_highlighted_bar_index = table_helpers.find_index(
		customization_menu.damage_meter_UI_highlighted_bar_types,
		config.current_config.damage_meter_UI.settings.highlighted_bar, false);

	customization_menu.damage_meter_UI_damage_bar_relative_index = table_helpers.find_index(
		customization_menu.damage_meter_UI_damage_bar_relative_types,
		config.current_config.damage_meter_UI.settings.damage_bar_relative_to, false);

	customization_menu.damage_meter_UI_my_damage_bar_location_index = table_helpers.find_index(
		customization_menu.damage_meter_UI_my_damage_bar_location_types,
		config.current_config.damage_meter_UI.settings.my_damage_bar_location, false);

	customization_menu.damage_meter_UI_sorting_type_index = table_helpers.find_index(
		customization_menu.damage_meter_UI_sorting_types, config.current_config.damage_meter_UI.sorting.type, false);

	customization_menu.selected_font_index = table_helpers.find_index(customization_menu.fonts,
		config.current_config.global_settings.UI_font.family, false);

	customization_menu.small_monster_UI_anchor_index = table_helpers.find_index(customization_menu.anchor_types,
		config.current_config.small_monster_UI.static_position.anchor, false);

	customization_menu.large_monster_UI_anchor_index = table_helpers.find_index(customization_menu.anchor_types,
		config.current_config.large_monster_UI.static.position.anchor, false);

	customization_menu.time_UI_anchor_index = table_helpers.find_index(customization_menu.anchor_types,
		config.current_config.time_UI.position.anchor, false);

	customization_menu.damage_meter_UI_anchor_index = table_helpers.find_index(customization_menu.anchor_types,
		config.current_config.damage_meter_UI.position.anchor, false);
end

function customization_menu.draw()
	imgui.set_next_window_pos(customization_menu.window_position, 1 << 3, customization_menu.window_pivot);
	imgui.set_next_window_size(customization_menu.window_size, 1 << 3);

	imgui.push_font(customization_menu.font);
	
	customization_menu.is_opened = imgui.begin_window(language.current_language.customization_menu.mod_name .. " " .. config.current_config.version, customization_menu.is_opened, customization_menu.window_flags);

	if not customization_menu.is_opened then
		return;
	end

	local config_changed = false;
	local changed = false;

	local status_string = tostring(customization_menu.status);
	imgui.text(language.current_language.customization_menu.status .. ": " .. status_string);

	if imgui.tree_node(language.current_language.customization_menu.modules) then
		changed, config.current_config.small_monster_UI.enabled = imgui.checkbox(language.current_language.customization_menu.small_monster_UI, config.current_config
			.small_monster_UI.enabled);
		config_changed = config_changed or changed;

		changed, config.current_config.large_monster_UI.dynamic.enabled =
			imgui.checkbox(language.current_language.customization_menu.large_monster_dynamic_UI, config.current_config.large_monster_UI.dynamic.enabled);
		config_changed = config_changed or changed;
		imgui.same_line();

		changed, config.current_config.large_monster_UI.static.enabled =
			imgui.checkbox(language.current_language.customization_menu.large_monster_static_UI, config.current_config.large_monster_UI.static.enabled);
		config_changed = config_changed or changed;

		changed, config.current_config.time_UI.enabled = imgui.checkbox(language.current_language.customization_menu.time_UI, config.current_config.time_UI.enabled);
		config_changed = config_changed or changed;
		imgui.same_line();

		changed, config.current_config.damage_meter_UI.enabled = imgui.checkbox(language.current_language.customization_menu.damage_meter_UI,
			config.current_config.damage_meter_UI.enabled);
		config_changed = config_changed or changed;

		imgui.tree_pop();
	end

	if imgui.tree_node(language.current_language.customization_menu.global_settings) then
		changed, customization_menu.selected_language_index = imgui.combo(language.current_language.customization_menu.language, customization_menu.selected_language_index, language.language_names);
		config_changed = config_changed or changed;
		if changed then
			config.current_config.global_settings.language = language.language_names[customization_menu.selected_language_index];
			language.update(customization_menu.selected_language_index);

			imgui.pop_font(customization_menu.font);
			customization_menu.init();
			imgui.push_font(customization_menu.font);

			part_names.init();
			large_monster.init_list();

			for _, monster in pairs(small_monster.list) do
				small_monster.init_UI(monster);
			end

			for _, _player in pairs(player.list) do
				player.init_UI(_player);
			end
		end

		if imgui.tree_node(language.current_language.customization_menu.menu_font) then
			changed, config.current_config.global_settings.menu_font.size =
			imgui.slider_int(" ", config.current_config.global_settings.menu_font.size, 5, 100);
			config_changed = config_changed or changed;
			imgui.same_line();

			if changed then
				imgui.pop_font(customization_menu.font);
				customization_menu.font = imgui.load_font(language.current_language.font_name, config.current_config.global_settings.menu_font.size, customization_menu.font_range);
				imgui.push_font(customization_menu.font);
			end

			changed = imgui.button("-");
			imgui.same_line();

			if changed then
				config.current_config.global_settings.menu_font.size = config.current_config.global_settings.menu_font.size - 1;
				if config.current_config.global_settings.menu_font.size < 5 then
					config.current_config.global_settings.menu_font.size = 10;
				end

				imgui.pop_font(customization_menu.font);
				customization_menu.font = imgui.load_font(language.current_language.font_name, config.current_config.global_settings.menu_font.size, customization_menu.font_range);
				imgui.push_font(customization_menu.font);
			end

			changed = imgui.button("+");
			imgui.same_line();

			if changed then
				config.current_config.global_settings.menu_font.size = config.current_config.global_settings.menu_font.size + 1;
				if config.current_config.global_settings.menu_font.size > 100 then
					config.current_config.global_settings.menu_font.size = 100;
				end

				imgui.pop_font(customization_menu.font);
				customization_menu.font = imgui.load_font(language.current_language.font_name, config.current_config.global_settings.menu_font.size, customization_menu.font_range);
				imgui.push_font(customization_menu.font);
			end

			
			imgui.text(language.current_language.customization_menu.size);

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.UI_font) then
			imgui.text(language.current_language.customization_menu.UI_font_notice);

			changed, customization_menu.selected_UI_font_index = imgui.combo(language.current_language.customization_menu.family, customization_menu.selected_UI_font_index,
				customization_menu.fonts);
			config_changed = config_changed or changed;
			if changed then
				config.current_config.global_settings.uUI_font.family = customization_menu.fonts[customization_menu.selected_UI_font_index];
			end

			changed, config.current_config.global_settings.UI_font.size =
				imgui.slider_int(language.current_language.customization_menu.size, config.current_config.global_settings.UI_font.size, 1, 100);
			config_changed = config_changed or changed;

			changed, config.current_config.global_settings.UI_font.bold =
				imgui.checkbox(language.current_language.customization_menu.bold, config.current_config.global_settings.UI_font.bold);
			config_changed = config_changed or changed;

			changed, config.current_config.global_settings.UI_font.italic =
				imgui.checkbox(language.current_language.customization_menu.italic, config.current_config.global_settings.UI_font.italic);
			config_changed = config_changed or changed;

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.performance) then
			changed, config.current_config.global_settings.performance.max_monster_updates_per_tick =
				imgui.slider_int(language.current_language.customization_menu.max_monster_updates_per_tick, config.current_config.global_settings.performance.max_monster_updates_per_tick, 1, 150);
			config_changed = config_changed or changed;

			changed, config.current_config.global_settings.performance.prioritize_large_monsters = imgui.checkbox(
				language.current_language.customization_menu.prioritize_large_monsters, config.current_config.global_settings.performance.prioritize_large_monsters);
			config_changed = config_changed or changed;

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.module_visibility_on_different_screens) then

			if imgui.tree_node(language.current_language.customization_menu.during_quest) then
				changed, config.current_config.global_settings.module_visibility.during_quest.small_monster_UI = imgui.checkbox(
					language.current_language.customization_menu.small_monster_UI, config.current_config.global_settings.module_visibility.during_quest.small_monster_UI);
				config_changed = config_changed or changed;

				changed, config.current_config.global_settings.module_visibility.during_quest.large_monster_dynamic_UI =
					imgui.checkbox(language.current_language.customization_menu.large_monster_dynamic_UI,
						config.current_config.global_settings.module_visibility.during_quest.large_monster_dynamic_UI);
				config_changed = config_changed or changed;
				imgui.same_line();

				changed, config.current_config.global_settings.module_visibility.during_quest.large_monster_static_UI =
					imgui.checkbox(language.current_language.customization_menu.large_monster_static_UI,
						config.current_config.global_settings.module_visibility.during_quest.large_monster_static_UI);
				config_changed = config_changed or changed;

				changed, config.current_config.global_settings.module_visibility.during_quest.time_UI = imgui.checkbox(language.current_language.customization_menu.time_UI,
					config.current_config.global_settings.module_visibility.during_quest.time_UI);
				config_changed = config_changed or changed;
				imgui.same_line();

				changed, config.current_config.global_settings.module_visibility.during_quest.damage_meter_UI = imgui.checkbox(
					language.current_language.customization_menu.damage_meter_UI, config.current_config.global_settings.module_visibility.during_quest.damage_meter_UI);
				config_changed = config_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.quest_summary_screen) then
				changed, config.current_config.global_settings.module_visibility.quest_summary_screen.small_monster_UI =
					imgui.checkbox(language.current_language.customization_menu.small_monster_UI,
						config.current_config.global_settings.module_visibility.quest_summary_screen.small_monster_UI);
				config_changed = config_changed or changed;

				changed, config.current_config.global_settings.module_visibility.quest_summary_screen.large_monster_dynamic_UI =
					imgui.checkbox(language.current_language.customization_menu.large_monster_dynamic_UI, config.current_config.global_settings.module_visibility
						.quest_summary_screen.large_monster_dynamic_UI);
				config_changed = config_changed or changed;
				imgui.same_line();

				changed, config.current_config.global_settings.module_visibility.quest_summary_screen.large_monster_static_UI =
					imgui.checkbox(language.current_language.customization_menu.large_monster_static_UI, config.current_config.global_settings.module_visibility
						.quest_summary_screen.large_monster_static_UI);
				config_changed = config_changed or changed;

				changed, config.current_config.global_settings.module_visibility.quest_summary_screen.time_UI = imgui.checkbox(
					language.current_language.customization_menu.time_UI, config.current_config.global_settings.module_visibility.quest_summary_screen.time_UI);
				config_changed = config_changed or changed;
				imgui.same_line();

				changed, config.current_config.global_settings.module_visibility.quest_summary_screen.damage_meter_UI =
					imgui.checkbox(language.current_language.customization_menu.damage_meter_UI,
						config.current_config.global_settings.module_visibility.quest_summary_screen.damage_meter_UI);
				config_changed = config_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.training_area) then
				changed, config.current_config.global_settings.module_visibility.training_area.large_monster_dynamic_UI =
					imgui.checkbox(language.current_language.customization_menu.large_monster_dynamic_UI,
						config.current_config.global_settings.module_visibility.training_area.large_monster_dynamic_UI);
				config_changed = config_changed or changed;
				imgui.same_line();

				changed, config.current_config.global_settings.module_visibility.training_area.large_monster_static_UI =
					imgui.checkbox(language.current_language.customization_menu.large_monster_static_UI,
						config.current_config.global_settings.module_visibility.training_area.large_monster_static_UI);
				config_changed = config_changed or changed;

				changed, config.current_config.global_settings.module_visibility.training_area.damage_meter_UI = imgui.checkbox(
					language.current_language.customization_menu.damage_meter_UI, config.current_config.global_settings.module_visibility.training_area.damage_meter_UI);
				config_changed = config_changed or changed;

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		imgui.tree_pop();
	end

	if imgui.tree_node(language.current_language.customization_menu.small_monster_UI) then
		local small_monster_UI_changed = false;
		changed, config.current_config.small_monster_UI.enabled = imgui.checkbox(language.current_language.customization_menu.enabled, config.current_config
			.small_monster_UI.enabled);
		config_changed = config_changed or changed;

		if imgui.tree_node(language.current_language.customization_menu.settings) then
			changed, config.current_config.small_monster_UI.settings.hide_dead_or_captured = imgui.checkbox(language.current_language.customization_menu.hide_dead_or_captured, config.current_config
			.small_monster_UI.settings.hide_dead_or_captured);
			config_changed = config_changed or changed;

			changed, customization_menu.small_monster_UI_orientation_index =
				imgui.combo(language.current_language.customization_menu.static_orientation, customization_menu.small_monster_UI_orientation_index,
					customization_menu.displayed_orientation_types);
			config_changed = config_changed or changed;
			if changed then
				config.current_config.small_monster_UI.settings.orientation =
					customization_menu.orientation_types[customization_menu.small_monster_UI_orientation_index];
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.dynamic_positioning) then
			changed, config.current_config.small_monster_UI.dynamic_positioning.enabled = imgui.checkbox(language.current_language.customization_menu.enabled,
				config.current_config.small_monster_UI.dynamic_positioning.enabled);
			config_changed = config_changed or changed;

			changed, config.current_config.small_monster_UI.dynamic_positioning.opacity_falloff = imgui.checkbox(
				language.current_language.customization_menu.opacity_falloff, config.current_config.small_monster_UI.dynamic_positioning.opacity_falloff);
			config_changed = config_changed or changed;

			changed, config.current_config.small_monster_UI.dynamic_positioning.max_distance =
				imgui.drag_float(language.current_language.customization_menu.max_distance, config.current_config.small_monster_UI.dynamic_positioning.max_distance, 1, 0,
					10000, "%.0f");
			config_changed = config_changed or changed;

			if imgui.tree_node(language.current_language.customization_menu.world_offset) then
				changed, config.current_config.small_monster_UI.dynamic_positioning.world_offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.small_monster_UI.dynamic_positioning.world_offset.x, 0.1, -100, 100, "%.1f");
				config_changed = config_changed or changed;

				changed, config.current_config.small_monster_UI.dynamic_positioning.world_offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.small_monster_UI.dynamic_positioning.world_offset.y, 0.1, -100, 100, "%.1f");
				config_changed = config_changed or changed;

				changed, config.current_config.small_monster_UI.dynamic_positioning.world_offset.z = imgui.drag_float(language.current_language.customization_menu.z,
					config.current_config.small_monster_UI.dynamic_positioning.world_offset.z, 0.1, -100, 100, "%.1f");
				config_changed = config_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.viewport_offset) then
				changed, config.current_config.small_monster_UI.dynamic_positioning.viewport_offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.small_monster_UI.dynamic_positioning.viewport_offset.x, 0.1, -screen.width, screen.width,
					"%.1f");
				config_changed = config_changed or changed;

				changed, config.current_config.small_monster_UI.dynamic_positioning.viewport_offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.small_monster_UI.dynamic_positioning.viewport_offset.y, 0.1, -screen.height, screen.height,
					"%.1f");
				config_changed = config_changed or changed;

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.static_position) then
			changed, config.current_config.small_monster_UI.static_position.x =
				imgui.drag_float(language.current_language.customization_menu.x, config.current_config.small_monster_UI.static_position.x, 0.1, 0, screen.width, "%.1f");
			config_changed = config_changed or changed;

			changed, config.current_config.small_monster_UI.static_position.y =
				imgui.drag_float(language.current_language.customization_menu.y, config.current_config.small_monster_UI.static_position.y, 0.1, 0, screen.height, "%.1f");
			config_changed = config_changed or changed;

			changed, customization_menu.small_monster_UI_anchor_index = imgui.combo(language.current_language.customization_menu.anchor,
				customization_menu.small_monster_UI_anchor_index, customization_menu.displayed_anchor_types);
			config_changed = config_changed or changed;
			if changed then
				config.current_config.small_monster_UI.static_position.anchor =
					customization_menu.anchor_types[customization_menu.small_monster_UI_anchor_index];
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.static_spacing) then
			changed, config.current_config.small_monster_UI.static_spacing.x =
				imgui.drag_float(language.current_language.customization_menu.x, config.current_config.small_monster_UI.static_spacing.x, 0.1, -screen.width, screen.width,
					"%.1f");
			config_changed = config_changed or changed;

			changed, config.current_config.small_monster_UI.static_spacing.y =
				imgui.drag_float(language.current_language.customization_menu.y, config.current_config.small_monster_UI.static_spacing.y, 0.1, -screen.height, screen.height,
					"%.1f");
			config_changed = config_changed or changed;

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.static_sorting) then
			changed, customization_menu.small_monster_UI_sorting_type_index = imgui.combo(language.current_language.customization_menu.type,
				customization_menu.small_monster_UI_sorting_type_index, customization_menu.displayed_monster_UI_sorting_types);
			config_changed = config_changed or changed;
			if changed then
				config.current_config.small_monster_UI.static_sorting.type =
					customization_menu.monster_UI_sorting_types[customization_menu.small_monster_UI_sorting_type_index];
			end

			changed, config.current_config.small_monster_UI.static_sorting.reversed_order =
				imgui.checkbox(language.current_language.customization_menu.reversed_order, config.current_config.small_monster_UI.static_sorting.reversed_order);
			config_changed = config_changed or changed;

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.monster_name_label) then
			changed, config.current_config.small_monster_UI.monster_name_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
				config.current_config.small_monster_UI.monster_name_label.visibility);
			config_changed = config_changed or changed;
			small_monster_UI_changed = small_monster_UI_changed or changed;

			if imgui.tree_node(language.current_language.customization_menu.offset) then
				changed, config.current_config.small_monster_UI.monster_name_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.small_monster_UI.monster_name_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				changed, config.current_config.small_monster_UI.monster_name_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.small_monster_UI.monster_name_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.color) then
				changed, config.current_config.small_monster_UI.monster_name_label.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.monster_name_label.color, customization_menu.color_picker_flags);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.shadow) then
				changed, config.current_config.small_monster_UI.monster_name_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.small_monster_UI.monster_name_label.shadow.visibility);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.small_monster_UI.monster_name_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.small_monster_UI.monster_name_label.shadow.offset.x, 0.1, -screen.width, screen.width,
						"%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.monster_name_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.small_monster_UI.monster_name_label.shadow.offset.y, 0.1, -screen.height, screen.height,
						"%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.small_monster_UI.monster_name_label.shadow.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.monster_name_label.shadow.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.health) then
			changed, config.current_config.small_monster_UI.health.visibility =
				imgui.checkbox(language.current_language.customization_menu.visible, config.current_config.small_monster_UI.health.visibility);
			config_changed = config_changed or changed;
			small_monster_UI_changed = small_monster_UI_changed or changed;

			if imgui.tree_node(language.current_language.customization_menu.text_label) then
				changed, config.current_config.small_monster_UI.health.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.small_monster_UI.health.text_label.visibility);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				-- add text format

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.small_monster_UI.health.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.small_monster_UI.health.text_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.health.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.small_monster_UI.health.text_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.small_monster_UI.health.text_label.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.health.text_label.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.shadow) then
					changed, config.current_config.small_monster_UI.health.text_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.small_monster_UI.health.text_label.shadow.visibility);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.small_monster_UI.health.text_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.small_monster_UI.health.text_label.shadow.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						changed, config.current_config.small_monster_UI.health.text_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.small_monster_UI.health.text_label.shadow.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.small_monster_UI.health.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.health.text_label.shadow.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.value_label) then
				changed, config.current_config.small_monster_UI.health.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.small_monster_UI.health.value_label.visibility);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				-- add text format

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.small_monster_UI.health.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.small_monster_UI.health.value_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.health.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.small_monster_UI.health.value_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.small_monster_UI.health.value_label.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.health.value_label.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.shadow) then
					changed, config.current_config.small_monster_UI.health.value_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.small_monster_UI.health.value_label.shadow.visibility);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.small_monster_UI.health.value_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.small_monster_UI.health.value_label.shadow.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						changed, config.current_config.small_monster_UI.health.value_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.small_monster_UI.health.value_label.shadow.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.small_monster_UI.health.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.health.value_label.shadow.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
				changed, config.current_config.small_monster_UI.health.percentage_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.small_monster_UI.health.percentage_label.visibility);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				-- add text format

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.small_monster_UI.health.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.small_monster_UI.health.percentage_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.health.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.small_monster_UI.health.percentage_label.offset.y, 0.1, -screen.height, screen.height,
						"%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.small_monster_UI.health.percentage_label.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.health.percentage_label.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.shadow) then
					changed, config.current_config.small_monster_UI.health.percentage_label.shadow.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.small_monster_UI.health.percentage_label.shadow.visibility);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.small_monster_UI.health.percentage_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.small_monster_UI.health.percentage_label.shadow.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						changed, config.current_config.small_monster_UI.health.percentage_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.small_monster_UI.health.percentage_label.shadow.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.small_monster_UI.health.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.health.percentage_label.shadow.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.bar) then
				changed, config.current_config.small_monster_UI.health.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.small_monster_UI.health.bar.visibility);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.small_monster_UI.health.bar.offset.x =
						imgui.drag_float(language.current_language.customization_menu.x, config.current_config.small_monster_UI.health.bar.offset.x, 0.1, -screen.width,
							screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.health.bar.offset.y =
						imgui.drag_float(language.current_language.customization_menu.y, config.current_config.small_monster_UI.health.bar.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.size) then
					changed, config.current_config.small_monster_UI.health.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
						config.current_config.small_monster_UI.health.bar.size.width, 0.1, 0, screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.health.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
						config.current_config.small_monster_UI.health.bar.size.height, 0.1, 0, screen.height, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.colors) then
					if imgui.tree_node(language.current_language.customization_menu.foreground) then
						changed, config.current_config.small_monster_UI.health.bar.colors.foreground = imgui.color_picker_argb("", config.current_config.small_monster_UI.health.bar.colors.foreground, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.background) then
						--	changed, config.current_config.small_monster_UI.health.bar.colors.background = imgui.color_picker_argb("", config.current_config.small_monster_UI.health.bar.colors.background, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.stamina) then
			changed, config.current_config.small_monster_UI.stamina.visibility =
				imgui.checkbox(language.current_language.customization_menu.visible, config.current_config.small_monster_UI.stamina.visibility);
			config_changed = config_changed or changed;
			small_monster_UI_changed = small_monster_UI_changed or changed;

			if imgui.tree_node(language.current_language.customization_menu.text_label) then
				changed, config.current_config.small_monster_UI.stamina.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.small_monster_UI.stamina.text_label.visibility);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				-- add text format

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.small_monster_UI.stamina.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.small_monster_UI.stamina.text_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.stamina.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.small_monster_UI.stamina.text_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.small_monster_UI.stamina.text_label.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.stamina.text_label.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.shadow) then
					changed, config.current_config.small_monster_UI.stamina.text_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.small_monster_UI.stamina.text_label.shadow.visibility);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.small_monster_UI.stamina.text_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.small_monster_UI.stamina.text_label.shadow.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						changed, config.current_config.small_monster_UI.stamina.text_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.small_monster_UI.stamina.text_label.shadow.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.small_monster_UI.stamina.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.stamina.text_label.shadow.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.value_label) then
				changed, config.current_config.small_monster_UI.stamina.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.small_monster_UI.stamina.value_label.visibility);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				-- add text format

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.small_monster_UI.stamina.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.small_monster_UI.stamina.value_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.stamina.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.small_monster_UI.stamina.value_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.small_monster_UI.stamina.value_label.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.stamina.value_label.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.shadow) then
					changed, config.current_config.small_monster_UI.stamina.value_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.small_monster_UI.stamina.value_label.shadow.visibility);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.small_monster_UI.stamina.value_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.small_monster_UI.stamina.value_label.shadow.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						changed, config.current_config.small_monster_UI.stamina.value_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.small_monster_UI.stamina.value_label.shadow.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.small_monster_UI.stamina.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.stamina.value_label.shadow.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
				changed, config.current_config.small_monster_UI.stamina.percentage_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.small_monster_UI.stamina.percentage_label.visibility);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				-- add text format

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.small_monster_UI.stamina.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.small_monster_UI.stamina.percentage_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.stamina.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.small_monster_UI.stamina.percentage_label.offset.y, 0.1, -screen.height, screen.height,
						"%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.small_monster_UI.stamina.percentage_label.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.stamina.percentage_label.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.shadow) then
					changed, config.current_config.small_monster_UI.stamina.percentage_label.shadow.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.small_monster_UI.stamina.percentage_label.shadow.visibility);
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.small_monster_UI.stamina.percentage_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.small_monster_UI.stamina.percentage_label.shadow.offset.x, 0.1, -screen.width,
							screen.width, "%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						changed, config.current_config.small_monster_UI.stamina.percentage_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.small_monster_UI.stamina.percentage_label.shadow.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.small_monster_UI.stamina.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.small_monster_UI.stamina.percentage_label.shadow.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.bar) then
				changed, config.current_config.small_monster_UI.stamina.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.small_monster_UI.stamina.bar.visibility);
				config_changed = config_changed or changed;
				small_monster_UI_changed = small_monster_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.small_monster_UI.stamina.bar.offset.x =
						imgui.drag_float(language.current_language.customization_menu.x, config.current_config.small_monster_UI.stamina.bar.offset.x, 0.1, -screen.width,
							screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.stamina.bar.offset.y =
						imgui.drag_float(language.current_language.customization_menu.y, config.current_config.small_monster_UI.stamina.bar.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.size) then
					changed, config.current_config.small_monster_UI.stamina.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
						config.current_config.small_monster_UI.stamina.bar.size.width, 0.1, 0, screen.width, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					changed, config.current_config.small_monster_UI.stamina.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
						config.current_config.small_monster_UI.stamina.bar.size.height, 0.1, 0, screen.height, "%.1f");
					config_changed = config_changed or changed;
					small_monster_UI_changed = small_monster_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.colors) then
					if imgui.tree_node(language.current_language.customization_menu.foreground) then
						changed, config.current_config.small_monster_UI.stamina.bar.colors.foreground = imgui.color_picker_argb("", config.current_config.small_monster_UI.stamina.bar.colors.foreground, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.background) then
						changed, config.current_config.small_monster_UI.stamina.bar.colors.background = imgui.color_picker_argb("", config.current_config.small_monster_UI.stamina.bar.colors.background, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						small_monster_UI_changed = small_monster_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if small_monster_UI_changed then
			for _, monster in pairs(small_monster.list) do
				small_monster.init_UI(monster);
			end
		end

		imgui.tree_pop();
	end

	if imgui.tree_node(language.current_language.customization_menu.large_monster_UI) then
		if imgui.tree_node(language.current_language.customization_menu.dynamically_positioned) then
			local large_monster_dynamic_UI_changed = false;

			changed, config.current_config.large_monster_UI.dynamic.enabled =
				imgui.checkbox(language.current_language.customization_menu.enabled, config.current_config.large_monster_UI.dynamic.enabled);
			config_changed = config_changed or changed;
			large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

			if imgui.tree_node(language.current_language.customization_menu.settings) then
				changed, config.current_config.large_monster_UI.dynamic.settings.hide_dead_or_captured = imgui.checkbox(language.current_language.customization_menu.hide_dead_or_captured, config.current_config.
				large_monster_UI.dynamic.settings.hide_dead_or_captured);
				config_changed = config_changed or changed;

				changed, config.current_config.large_monster_UI.dynamic.settings.opacity_falloff =
					imgui.checkbox(language.current_language.customization_menu.opacity_falloff, config.current_config.large_monster_UI.dynamic.settings.opacity_falloff);
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				changed, config.current_config.large_monster_UI.dynamic.settings.max_distance =
					imgui.drag_float(language.current_language.customization_menu.max_distance, config.current_config.large_monster_UI.dynamic.settings.max_distance, 1, 0, 10000,
						"%.0f");
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.world_offset) then
				changed, config.current_config.large_monster_UI.dynamic.world_offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.large_monster_UI.dynamic.world_offset.x, 0.1, -100, 100, "%.1f");
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				changed, config.current_config.large_monster_UI.dynamic.world_offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.large_monster_UI.dynamic.world_offset.y, 0.1, -100, 100, "%.1f");
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				changed, config.current_config.large_monster_UI.dynamic.world_offset.z = imgui.drag_float(language.current_language.customization_menu.z,
					config.current_config.large_monster_UI.dynamic.world_offset.z, 0.1, -100, 100, "%.1f");
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.viewport_offset) then
				changed, config.current_config.large_monster_UI.dynamic.viewport_offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.large_monster_UI.dynamic.viewport_offset.x, 0.1, -screen.width, screen.width, "%.1f");
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				changed, config.current_config.large_monster_UI.dynamic.viewport_offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.large_monster_UI.dynamic.viewport_offset.y, 0.1, -screen.height, screen.height, "%.1f");
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.monster_name_label) then
				changed, config.current_config.large_monster_UI.dynamic.monster_name_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.dynamic.monster_name_label.visibility);
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.include) then
					changed, config.current_config.large_monster_UI.dynamic.monster_name_label.include.monster_name = imgui.checkbox(
						language.current_language.customization_menu.monster_name, config.current_config.large_monster_UI.dynamic.monster_name_label.include.monster_name);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					changed, config.current_config.large_monster_UI.dynamic.monster_name_label.include.crown = imgui.checkbox(language.current_language.customization_menu.crown,
						config.current_config.large_monster_UI.dynamic.monster_name_label.include.crown);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					changed, config.current_config.large_monster_UI.dynamic.monster_name_label.include.size = imgui.checkbox(language.current_language.customization_menu.size,
						config.current_config.large_monster_UI.dynamic.monster_name_label.include.size);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					changed, config.current_config.large_monster_UI.dynamic.monster_name_label.include.scrown_thresholds =
						imgui.checkbox(language.current_language.customization_menu.crown_thresholds,
							config.current_config.large_monster_UI.dynamic.monster_name_label.include.scrown_thresholds);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.large_monster_UI.dynamic.monster_name_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.large_monster_UI.dynamic.monster_name_label.offset.x, 0.1, -screen.width, screen.width,
						"%.1f");
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					changed, config.current_config.large_monster_UI.dynamic.monster_name_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.large_monster_UI.dynamic.monster_name_label.offset.y, 0.1, -screen.height, screen.height,
						"%.1f");
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.large_monster_UI.dynamic.monster_name_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.monster_name_label.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.shadow) then
					changed, config.current_config.large_monster_UI.dynamic.monster_name_label.shadow.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.monster_name_label.shadow.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.monster_name_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.monster_name_label.shadow.offset.x, 0.1, -screen.width,
							screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.monster_name_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.monster_name_label.shadow.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.monster_name_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.monster_name_label.shadow.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.health) then
				changed, config.current_config.large_monster_UI.dynamic.health.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.dynamic.health.visibility);
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.text_label) then
					changed, config.current_config.large_monster_UI.dynamic.health.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.health.text_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.health.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.health.text_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.health.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.health.text_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.health.text_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.text_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.health.text_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.health.text_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.health.text_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.dynamic.health.text_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.health.text_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.dynamic.health.text_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.health.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.text_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.value_label) then
					changed, config.current_config.large_monster_UI.dynamic.health.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.health.value_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.health.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.health.value_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.health.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.health.value_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.health.value_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.value_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.health.value_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.health.value_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.health.value_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.dynamic.health.value_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.health.value_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.dynamic.health.value_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.health.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.value_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
					changed, config.current_config.large_monster_UI.dynamic.health.percentage_label.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.health.percentage_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.health.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.health.percentage_label.offset.x, 0.1, -screen.width,
							screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.health.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.health.percentage_label.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.health.percentage_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.percentage_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.health.percentage_label.shadow.visibility =
							imgui.checkbox(language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.health.percentage_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.health.percentage_label.shadow.offset.x =
								imgui.drag_float(language.current_language.customization_menu.x, config.current_config.large_monster_UI.dynamic.health.percentage_label.shadow.offset.x,
									0.1, -screen.width, screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.health.percentage_label.shadow.offset.y =
								imgui.drag_float(language.current_language.customization_menu.y, config.current_config.large_monster_UI.dynamic.health.percentage_label.shadow.offset.y,
									0.1, -screen.height, screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.health.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.percentage_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.bar) then
					changed, config.current_config.large_monster_UI.dynamic.health.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.health.bar.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.health.bar.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.health.bar.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.health.bar.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.health.bar.offset.y, 0.1, -screen.height, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.size) then
						changed, config.current_config.large_monster_UI.dynamic.health.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
							config.current_config.large_monster_UI.dynamic.health.bar.size.width, 0.1, 0, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.health.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
							config.current_config.large_monster_UI.dynamic.health.bar.size.height, 0.1, 0, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.colors) then
						if imgui.tree_node(language.current_language.customization_menu.foreground) then
							changed, config.current_config.large_monster_UI.dynamic.health.bar.normal_colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.bar.normal_colors.foreground, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.background) then
							changed, config.current_config.large_monster_UI.dynamic.health.bar.normal_colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.bar.normal_colors.background, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.monster_can_be_captured) then
							if imgui.tree_node(language.current_language.customization_menu.foreground) then
								changed, config.current_config.large_monster_UI.dynamic.health.bar.capture_colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.bar.capture_colors.foreground, customization_menu.color_picker_flags);
								config_changed = config_changed or changed;
								large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

								imgui.tree_pop();
							end

							if imgui.tree_node(language.current_language.customization_menu.background) then
								changed, config.current_config.large_monster_UI.dynamic.health.bar.capture_colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.bar.capture_colors.background, customization_menu.color_picker_flags);
								config_changed = config_changed or changed;
								large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

								imgui.tree_pop();
							end
						end

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.capture_line) then
						changed, config.current_config.large_monster_UI.dynamic.health.bar.capture_line.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
							config.current_config.large_monster_UI.dynamic.health.bar.capture_line.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;
	
						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.health.bar.capture_line.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.dynamic.health.bar.capture_line.offset.x, 0.1, -screen.width, screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;
	
							changed, config.current_config.large_monster_UI.dynamic.health.bar.capture_line.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.dynamic.health.bar.capture_line.offset.y, 0.1, -screen.height, screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;
	
							imgui.tree_pop();
						end
	
						if imgui.tree_node(language.current_language.customization_menu.size) then
							changed, config.current_config.large_monster_UI.dynamic.health.bar.capture_line.size.width = imgui.drag_float(language.current_language.customization_menu.width,
								config.current_config.large_monster_UI.dynamic.health.bar.capture_line.size.width, 0.1, 0, screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;
	
							changed, config.current_config.large_monster_UI.dynamic.health.bar.capture_line.size.height = imgui.drag_float(language.current_language.customization_menu.height,
								config.current_config.large_monster_UI.dynamic.health.bar.capture_line.size.height, 0.1, 0, screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;
	
							imgui.tree_pop();
						end
	
						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.health.bar.capture_line.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.health.bar.capture_line.color, customization_menu.color_picker_flags);
								config_changed = config_changed or changed;
								large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;
	
							imgui.tree_pop();
						end
	
						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.stamina) then
				changed, config.current_config.large_monster_UI.dynamic.stamina.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.dynamic.stamina.visibility);
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.text_label) then
					changed, config.current_config.large_monster_UI.dynamic.stamina.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.stamina.text_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.stamina.text_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.stamina.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.stamina.text_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.text_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.stamina.text_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.text_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.stamina.text_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.stamina.text_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.dynamic.stamina.text_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.stamina.text_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.dynamic.stamina.text_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.stamina.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.stamina.text_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.value_label) then
					changed, config.current_config.large_monster_UI.dynamic.stamina.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.stamina.value_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.stamina.value_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.stamina.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.stamina.value_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.value_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.stamina.value_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.value_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.stamina.value_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.stamina.value_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.dynamic.stamina.value_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.stamina.value_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.dynamic.stamina.value_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.stamina.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.stamina.value_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
					changed, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.stamina.percentage_label.offset.x, 0.1, -screen.width,
							screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.stamina.percentage_label.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.stamina.percentage_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.shadow.visibility =
							imgui.checkbox(language.current_language.customization_menu.visible,
								config.current_config.large_monster_UI.dynamic.stamina.percentage_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.shadow.offset.x =
								imgui.drag_float(language.current_language.customization_menu.x, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.shadow.offset.x,
									0.1, -screen.width, screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.shadow.offset.y =
								imgui.drag_float(language.current_language.customization_menu.y, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.shadow.offset.y,
									0.1, -screen.height, screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.stamina.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.stamina.percentage_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.bar) then
					changed, config.current_config.large_monster_UI.dynamic.stamina.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.stamina.bar.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.bar.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.stamina.bar.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.stamina.bar.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.stamina.bar.offset.y, 0.1, -screen.height, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.size) then
						changed, config.current_config.large_monster_UI.dynamic.stamina.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
							config.current_config.large_monster_UI.dynamic.stamina.bar.size.width, 0.1, 0, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.stamina.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
							config.current_config.large_monster_UI.dynamic.stamina.bar.size.height, 0.1, 0, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.colors) then
						if imgui.tree_node(language.current_language.customization_menu.foreground) then
							changed, config.current_config.large_monster_UI.dynamic.stamina.bar.colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.stamina.bar.colors.foreground, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.background) then
							changed, config.current_config.large_monster_UI.dynamic.stamina.bar.colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.stamina.bar.colors.background, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.rage) then
				changed, config.current_config.large_monster_UI.dynamic.rage.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.dynamic.rage.visibility);
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.text_label) then
					changed, config.current_config.large_monster_UI.dynamic.rage.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.rage.text_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.rage.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.rage.text_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.rage.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.rage.text_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.rage.text_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.text_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.rage.text_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.rage.text_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.rage.text_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.dynamic.rage.text_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.rage.text_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.dynamic.rage.text_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.rage.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.text_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.value_label) then
					changed, config.current_config.large_monster_UI.dynamic.rage.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.rage.value_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.rage.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.rage.value_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.rage.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.rage.value_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.rage.value_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.value_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.rage.value_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.rage.value_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.rage.value_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.dynamic.rage.value_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.rage.value_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.dynamic.rage.value_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.rage.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.value_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
					changed, config.current_config.large_monster_UI.dynamic.rage.percentage_label.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.rage.percentage_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.rage.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.rage.percentage_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.rage.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.rage.percentage_label.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.rage.percentage_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.percentage_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.rage.percentage_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.rage.percentage_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.rage.percentage_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.dynamic.rage.percentage_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.rage.percentage_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.dynamic.rage.percentage_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.rage.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.percentage_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.timer_label) then
					changed, config.current_config.large_monster_UI.dynamic.rage.timer_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.rage.timer_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.rage.timer_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.rage.timer_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.rage.timer_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.rage.timer_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.rage.timer_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.timer_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.rage.timer_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.rage.timer_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.rage.timer_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.dynamic.rage.timer_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.rage.timer_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.dynamic.rage.timer_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.rage.timer_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.timer_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.bar) then
					changed, config.current_config.large_monster_UI.dynamic.rage.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.rage.bar.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.rage.bar.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.rage.bar.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.rage.bar.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.rage.bar.offset.y, 0.1, -screen.height, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.size) then
						changed, config.current_config.large_monster_UI.dynamic.rage.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
							config.current_config.large_monster_UI.dynamic.rage.bar.size.width, 0.1, 0, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.rage.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
							config.current_config.large_monster_UI.dynamic.rage.bar.size.height, 0.1, 0, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.colors) then
						if imgui.tree_node(language.current_language.customization_menu.foreground) then
							changed, config.current_config.large_monster_UI.dynamic.rage.bar.colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.bar.colors.foreground, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.background) then
							changed, config.current_config.large_monster_UI.dynamic.rage.bar.colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.rage.bar.colors.background, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.body_parts) then
				changed, config.current_config.large_monster_UI.dynamic.parts.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.dynamic.parts.visibility);
				config_changed = config_changed or changed;
				large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.large_monster_UI.dynamic.parts.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.large_monster_UI.dynamic.parts.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					changed, config.current_config.large_monster_UI.dynamic.parts.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.large_monster_UI.dynamic.parts.offset.y, 0.1, -screen.height, screen.height, "%.1f");
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.spacing) then
					changed, config.current_config.large_monster_UI.dynamic.parts.spacing.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.large_monster_UI.dynamic.parts.spacing.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					changed, config.current_config.large_monster_UI.dynamic.parts.spacing.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.large_monster_UI.dynamic.parts.spacing.y, 0.1, -screen.height, screen.height, "%.1f");
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.settings) then
					changed, config.current_config.large_monster_UI.dynamic.parts.settings.hide_undamaged_parts = imgui.checkbox(
						language.current_language.customization_menu.hide_undamaged_parts, config.current_config.large_monster_UI.dynamic.parts.settings.hide_undamaged_parts);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.sorting) then
					changed, customization_menu.large_monster_dynamic_UI_parts_sorting_type_index = imgui.combo(language.current_language.customization_menu.type,
						customization_menu.large_monster_dynamic_UI_parts_sorting_type_index,
						customization_menu.displayed_large_monster_UI_parts_sorting_types);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;
					if changed then
						config.current_config.large_monster_UI.dynamic.parts.sorting.type =
							customization_menu.large_monster_UI_parts_sorting_types[customization_menu.large_monster_dynamic_UI_parts_sorting_type_index];
					end

					changed, config.current_config.large_monster_UI.dynamic.parts.sorting.reversed_order = imgui.checkbox(
						language.current_language.customization_menu.reversed_order, config.current_config.large_monster_UI.dynamic.parts.sorting.reversed_order);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.part_name_label) then
					changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.parts.part_name_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.include) then
						changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.include.part_name = imgui.checkbox(
							language.current_language.customization_menu.part_name, config.current_config.large_monster_UI.dynamic.parts.part_name_label.include.part_name);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.include.break_count =
							imgui.checkbox(language.current_language.customization_menu.break_count,
								config.current_config.large_monster_UI.dynamic.parts.part_name_label.include.break_count);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.parts.part_name_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.parts.part_name_label.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.part_name_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.parts.part_name_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.dynamic.parts.part_name_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.dynamic.parts.part_name_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.parts.part_name_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.part_name_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.text_label) then
					changed, config.current_config.large_monster_UI.dynamic.parts.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.parts.text_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.parts.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.parts.text_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.parts.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.parts.text_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.parts.text_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.text_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.parts.text_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.parts.text_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.parts.text_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.dynamic.parts.text_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.parts.text_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.dynamic.parts.text_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.parts.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.text_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.value_label) then
					changed, config.current_config.large_monster_UI.dynamic.parts.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.parts.value_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.parts.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.parts.value_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.parts.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.parts.value_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.parts.value_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.value_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.parts.value_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.parts.value_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.parts.value_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.dynamic.parts.value_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.parts.value_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.dynamic.parts.value_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.parts.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.value_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
					changed, config.current_config.large_monster_UI.dynamic.parts.percentage_label.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.parts.percentage_label.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.parts.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.parts.percentage_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.parts.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.parts.percentage_label.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.dynamic.parts.percentage_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.percentage_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.dynamic.parts.percentage_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.dynamic.parts.percentage_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.dynamic.parts.percentage_label.shadow.offset.x =
								imgui.drag_float(language.current_language.customization_menu.x, config.current_config.large_monster_UI.dynamic.parts.percentage_label.shadow.offset.x,
									0.1, -screen.width, screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							changed, config.current_config.large_monster_UI.dynamic.parts.percentage_label.shadow.offset.y =
								imgui.drag_float(language.current_language.customization_menu.y, config.current_config.large_monster_UI.dynamic.parts.percentage_label.shadow.offset.y,
									0.1, -screen.height, screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.dynamic.parts.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.percentage_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.bar) then
					changed, config.current_config.large_monster_UI.dynamic.parts.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.dynamic.parts.bar.visibility);
					config_changed = config_changed or changed;
					large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.dynamic.parts.bar.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.dynamic.parts.bar.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.parts.bar.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.dynamic.parts.bar.offset.y, 0.1, -screen.height, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.size) then
						changed, config.current_config.large_monster_UI.dynamic.parts.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
							config.current_config.large_monster_UI.dynamic.parts.bar.size.width, 0.1, 0, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						changed, config.current_config.large_monster_UI.dynamic.parts.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
							config.current_config.large_monster_UI.dynamic.parts.bar.size.height, 0.1, 0, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.colors) then
						if imgui.tree_node(language.current_language.customization_menu.foreground) then
							changed, config.current_config.large_monster_UI.dynamic.parts.bar.colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.bar.colors.foreground, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.background) then
							changed, config.current_config.large_monster_UI.dynamic.parts.bar.colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.dynamic.parts.bar.colors.background, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_dynamic_UI_changed = large_monster_dynamic_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if large_monster_dynamic_UI_changed then
				for _, monster in pairs(large_monster.list) do
					large_monster.init_dynamic_UI(monster);
				end
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.statically_positioned) then
			local large_monster_static_UI_changed = false;

			changed, config.current_config.large_monster_UI.static.enabled =
				imgui.checkbox(language.current_language.customization_menu.enabled, config.current_config.large_monster_UI.static.enabled);
			config_changed = config_changed or changed;
			large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

			if imgui.tree_node(language.current_language.customization_menu.settings) then
				changed, config.current_config.large_monster_UI.static.settings.hide_dead_or_captured = imgui.checkbox(language.current_language.customization_menu.hide_dead_or_captured, config.current_config.
				large_monster_UI.static.settings.hide_dead_or_captured);
				config_changed = config_changed or changed;

				changed, customization_menu.large_monster_UI_orientation_index = imgui.combo(language.current_language.customization_menu.orientation,
					customization_menu.large_monster_UI_orientation_index, customization_menu.displayed_orientation_types);
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;
				if changed then
					config.current_config.large_monster_UI.static.settings.orientation =
						customization_menu.orientation_types[customization_menu.large_monster_UI_orientation_index];
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.position) then
				changed, config.current_config.large_monster_UI.static.position.x =
					imgui.drag_float(language.current_language.customization_menu.x, config.current_config.large_monster_UI.static.position.x, 0.1, 0, screen.width, "%.1f");
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				changed, config.current_config.large_monster_UI.static.position.y =
					imgui.drag_float(language.current_language.customization_menu.y, config.current_config.large_monster_UI.static.position.y, 0.1, 0, screen.height, "%.1f");
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				changed, customization_menu.large_monster_UI_anchor_index = imgui.combo(language.current_language.customization_menu.anchor,
					customization_menu.large_monster_UI_anchor_index, customization_menu.displayed_anchor_types);
				config_changed = config_changed or changed;
				if changed then
					config.current_config.large_monster_UI.static.position.anchor =
						customization_menu.anchor_types[customization_menu.large_monster_UI_anchor_index];
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.spacing) then
				changed, config.current_config.large_monster_UI.static.spacing.x =
					imgui.drag_float(language.current_language.customization_menu.x, config.current_config.large_monster_UI.static.spacing.x, 0.1, -screen.width, screen.width,
						"%.1f");
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				changed, config.current_config.large_monster_UI.static.spacing.y =
					imgui.drag_float(language.current_language.customization_menu.y, config.current_config.large_monster_UI.static.spacing.y, 0.1, -screen.height, screen.height,
						"%.1f");
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.sorting) then
				changed, customization_menu.monster_UI_sort_type_index = imgui.combo(language.current_language.customization_menu.type,
					customization_menu.monster_UI_sort_type_index, customization_menu.displayed_monster_UI_sorting_types);
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;
				if changed then
					config.current_config.large_monster_UI.static.sorting.type =
						customization_menu.monster_UI_sorting_types[customization_menu.monster_UI_sort_type_index];
				end

				changed, config.current_config.large_monster_UI.static.sorting.reversed_order =
					imgui.checkbox(language.current_language.customization_menu.reversed_order, config.current_config.large_monster_UI.static.sorting.reversed_order);
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.monster_name_label) then
				changed, config.current_config.large_monster_UI.static.monster_name_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.static.monster_name_label.visibility);
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.include) then
					changed, config.current_config.large_monster_UI.static.monster_name_label.include.monster_name = imgui.checkbox(
						language.current_language.customization_menu.monster_name, config.current_config.large_monster_UI.static.monster_name_label.include.monster_name);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					changed, config.current_config.large_monster_UI.static.monster_name_label.include.crown = imgui.checkbox(language.current_language.customization_menu.crown,
						config.current_config.large_monster_UI.static.monster_name_label.include.crown);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					changed, config.current_config.large_monster_UI.static.monster_name_label.include.size = imgui.checkbox(language.current_language.customization_menu.size,
						config.current_config.large_monster_UI.static.monster_name_label.include.size);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					changed, config.current_config.large_monster_UI.static.monster_name_label.include.scrown_thresholds =
						imgui.checkbox(language.current_language.customization_menu.crown_thresholds,
							config.current_config.large_monster_UI.static.monster_name_label.include.scrown_thresholds);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.large_monster_UI.static.monster_name_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.large_monster_UI.static.monster_name_label.offset.x, 0.1, -screen.width, screen.width,
						"%.1f");
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					changed, config.current_config.large_monster_UI.static.monster_name_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.large_monster_UI.static.monster_name_label.offset.y, 0.1, -screen.height, screen.height,
						"%.1f");
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.large_monster_UI.static.monster_name_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.monster_name_label.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.shadow) then
					changed, config.current_config.large_monster_UI.static.monster_name_label.shadow.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.monster_name_label.shadow.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.monster_name_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.monster_name_label.shadow.offset.x, 0.1, -screen.width,
							screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.monster_name_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.monster_name_label.shadow.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.monster_name_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.monster_name_label.shadow.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.health) then
				changed, config.current_config.large_monster_UI.static.health.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.static.health.visibility);
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.text_label) then
					changed, config.current_config.large_monster_UI.static.health.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.health.text_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.health.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.health.text_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.health.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.health.text_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.health.text_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.text_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.health.text_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.health.text_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.health.text_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.static.health.text_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.health.text_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.static.health.text_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.health.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.text_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.value_label) then
					changed, config.current_config.large_monster_UI.static.health.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.health.value_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.health.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.health.value_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.health.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.health.value_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.health.value_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.value_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.health.value_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.health.value_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.health.value_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.static.health.value_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.health.value_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.static.health.value_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.health.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.value_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
					changed, config.current_config.large_monster_UI.static.health.percentage_label.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.health.percentage_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.health.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.health.percentage_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.health.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.health.percentage_label.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.health.percentage_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.percentage_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.health.percentage_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.health.percentage_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.health.percentage_label.shadow.offset.x =
								imgui.drag_float(language.current_language.customization_menu.x, config.current_config.large_monster_UI.static.health.percentage_label.shadow.offset.x,
									0.1, -screen.width, screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.health.percentage_label.shadow.offset.y =
								imgui.drag_float(language.current_language.customization_menu.y, config.current_config.large_monster_UI.static.health.percentage_label.shadow.offset.y,
									0.1, -screen.height, screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.health.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.percentage_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.bar) then
					changed, config.current_config.large_monster_UI.static.health.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.health.bar.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.health.bar.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.health.bar.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.health.bar.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.health.bar.offset.y, 0.1, -screen.height, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.size) then
						changed, config.current_config.large_monster_UI.static.health.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
							config.current_config.large_monster_UI.static.health.bar.size.width, 0.1, 0, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.health.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
							config.current_config.large_monster_UI.static.health.bar.size.height, 0.1, 0, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.colors) then
						if imgui.tree_node(language.current_language.customization_menu.foreground) then
							changed, config.current_config.large_monster_UI.static.health.bar.normal_colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.bar.normal_colors.foreground, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.background) then
							changed, config.current_config.large_monster_UI.static.health.bar.normal_colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.bar.normal_colors.background, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.monster_can_be_captured) then
							if imgui.tree_node(language.current_language.customization_menu.foreground) then
								changed, config.current_config.large_monster_UI.static.health.bar.capture_colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.bar.capture_colors.foreground, customization_menu.color_picker_flags);
								config_changed = config_changed or changed;
								large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

								imgui.tree_pop();
							end

							if imgui.tree_node(language.current_language.customization_menu.background) then
								changed, config.current_config.large_monster_UI.static.health.bar.capture_colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.bar.capture_colors.background, customization_menu.color_picker_flags);
								config_changed = config_changed or changed;
								large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

								imgui.tree_pop();
							end
						end

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.capture_line) then
						changed, config.current_config.large_monster_UI.static.health.bar.capture_line.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
							config.current_config.large_monster_UI.static.health.bar.capture_line.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;
	
						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.health.bar.capture_line.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.static.health.bar.capture_line.offset.x, 0.1, -screen.width, screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;
	
							changed, config.current_config.large_monster_UI.static.health.bar.capture_line.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.static.health.bar.capture_line.offset.y, 0.1, -screen.height, screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;
	
							imgui.tree_pop();
						end
	
						if imgui.tree_node(language.current_language.customization_menu.size) then
							changed, config.current_config.large_monster_UI.static.health.bar.capture_line.size.width = imgui.drag_float(language.current_language.customization_menu.width,
								config.current_config.large_monster_UI.static.health.bar.capture_line.size.width, 0.1, 0, screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;
	
							changed, config.current_config.large_monster_UI.static.health.bar.capture_line.size.height = imgui.drag_float(language.current_language.customization_menu.height,
								config.current_config.large_monster_UI.static.health.bar.capture_line.size.height, 0.1, 0, screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;
	
							imgui.tree_pop();
						end
	
						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.health.bar.capture_line.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.health.bar.capture_line.color, customization_menu.color_picker_flags);
								config_changed = config_changed or changed;
								large_monster_static_UI_changed = large_monster_static_UI_changed or changed;
	
							imgui.tree_pop();
						end
	
						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.stamina) then
				changed, config.current_config.large_monster_UI.static.stamina.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.static.stamina.visibility);
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.text_label) then
					changed, config.current_config.large_monster_UI.static.stamina.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.stamina.text_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.stamina.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.stamina.text_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.stamina.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.stamina.text_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.stamina.text_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.stamina.text_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.stamina.text_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.stamina.text_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.stamina.text_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.static.stamina.text_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.stamina.text_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.static.stamina.text_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.stamina.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.stamina.text_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.value_label) then
					changed, config.current_config.large_monster_UI.static.stamina.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.stamina.value_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.stamina.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.stamina.value_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.stamina.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.stamina.value_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.stamina.value_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.stamina.value_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.stamina.value_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.stamina.value_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.stamina.value_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.static.stamina.value_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.stamina.value_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.static.stamina.value_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.stamina.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.stamina.value_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
					changed, config.current_config.large_monster_UI.static.stamina.percentage_label.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.stamina.percentage_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.stamina.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.stamina.percentage_label.offset.x, 0.1, -screen.width,
							screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.stamina.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.stamina.percentage_label.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.stamina.percentage_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.stamina.percentage_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.stamina.percentage_label.shadow.visibility =
							imgui.checkbox(language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.stamina.percentage_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.stamina.percentage_label.shadow.offset.x =
								imgui.drag_float(language.current_language.customization_menu.x, config.current_config.large_monster_UI.static.stamina.percentage_label.shadow.offset.x,
									0.1, -screen.width, screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.stamina.percentage_label.shadow.offset.y =
								imgui.drag_float(language.current_language.customization_menu.y, config.current_config.large_monster_UI.static.stamina.percentage_label.shadow.offset.y,
									0.1, -screen.height, screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.stamina.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.stamina.percentage_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.bar) then
					changed, config.current_config.large_monster_UI.static.stamina.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.stamina.bar.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.stamina.bar.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.stamina.bar.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.stamina.bar.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.stamina.bar.offset.y, 0.1, -screen.height, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.size) then
						changed, config.current_config.large_monster_UI.static.stamina.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
							config.current_config.large_monster_UI.static.stamina.bar.size.width, 0.1, 0, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.stamina.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
							config.current_config.large_monster_UI.static.stamina.bar.size.height, 0.1, 0, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.colors) then
						if imgui.tree_node(language.current_language.customization_menu.foreground) then
							changed, config.current_config.large_monster_UI.static.stamina.bar.colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.stamina.bar.colors.foreground, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.background) then
							changed, config.current_config.large_monster_UI.static.stamina.bar.colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.stamina.bar.colors.background, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.rage) then
				changed, config.current_config.large_monster_UI.static.rage.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.static.rage.visibility);
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.text_label) then
					changed, config.current_config.large_monster_UI.static.rage.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.rage.text_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.rage.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.rage.text_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.rage.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.rage.text_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.rage.text_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.text_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.rage.text_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.rage.text_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.rage.text_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.static.rage.text_label.shadow.offset.x, 0.1, -screen.width, screen.width,
								"%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.rage.text_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.static.rage.text_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.rage.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.text_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.value_label) then
					changed, config.current_config.large_monster_UI.static.rage.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.rage.value_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.rage.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.rage.value_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.rage.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.rage.value_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.rage.value_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.value_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.rage.value_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.rage.value_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.rage.value_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.static.rage.value_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.rage.value_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.static.rage.value_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.rage.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.value_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
					changed, config.current_config.large_monster_UI.static.rage.percentage_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.rage.percentage_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.rage.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.rage.percentage_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.rage.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.rage.percentage_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.rage.percentage_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.percentage_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.rage.percentage_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.rage.percentage_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.rage.percentage_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.static.rage.percentage_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.rage.percentage_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.static.rage.percentage_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.rage.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.percentage_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.timer_label) then
					changed, config.current_config.large_monster_UI.static.rage.timer_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.rage.timer_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.rage.timer_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.rage.timer_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.rage.timer_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.rage.timer_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.rage.timer_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.timer_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.rage.timer_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.rage.timer_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.rage.timer_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.static.rage.timer_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.rage.timer_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.static.rage.timer_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.rage.timer_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.timer_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.bar) then
					changed, config.current_config.large_monster_UI.static.rage.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.rage.bar.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.rage.bar.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.rage.bar.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.rage.bar.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.rage.bar.offset.y, 0.1, -screen.height, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.size) then
						changed, config.current_config.large_monster_UI.static.rage.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
							config.current_config.large_monster_UI.static.rage.bar.size.width, 0.1, 0, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.rage.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
							config.current_config.large_monster_UI.static.rage.bar.size.height, 0.1, 0, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.colors) then
						if imgui.tree_node(language.current_language.customization_menu.foreground) then
							changed, config.current_config.large_monster_UI.static.rage.bar.colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.bar.colors.foreground, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.background) then
							changed, config.current_config.large_monster_UI.static.rage.bar.colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.rage.bar.colors.background, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.body_parts) then
				changed, config.current_config.large_monster_UI.static.parts.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.large_monster_UI.static.parts.visibility);
				config_changed = config_changed or changed;
				large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.large_monster_UI.static.parts.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.large_monster_UI.static.parts.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					changed, config.current_config.large_monster_UI.static.parts.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.large_monster_UI.static.parts.offset.y, 0.1, -screen.height, screen.height, "%.1f");
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.spacing) then
					changed, config.current_config.large_monster_UI.static.parts.spacing.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.large_monster_UI.static.parts.spacing.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					changed, config.current_config.large_monster_UI.static.parts.spacing.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.large_monster_UI.static.parts.spacing.y, 0.1, -screen.height, screen.height, "%.1f");
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.settings) then
					changed, config.current_config.large_monster_UI.static.parts.settings.hide_undamaged_parts = imgui.checkbox(
						language.current_language.customization_menu.hide_undamaged_parts, config.current_config.large_monster_UI.static.parts.settings.hide_undamaged_parts);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.sorting) then
					changed, customization_menu.large_monster_static_UI_parts_sorting_type_index = imgui.combo(language.current_language.customization_menu.type,
						customization_menu.large_monster_static_UI_parts_sorting_type_index,
						customization_menu.displayed_large_monster_UI_parts_sorting_types);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;
					if changed then
						config.current_config.large_monster_UI.static.parts.sorting.type =
							customization_menu.large_monster_UI_parts_sorting_types[customization_menu.large_monster_static_UI_parts_sorting_type_index];
					end

					changed, config.current_config.large_monster_UI.static.parts.sorting.reversed_order = imgui.checkbox(
						language.current_language.customization_menu.reversed_order, config.current_config.large_monster_UI.static.parts.sorting.reversed_order);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.part_name_label) then
					changed, config.current_config.large_monster_UI.static.parts.part_name_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.parts.part_name_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.include) then
						changed, config.current_config.large_monster_UI.static.parts.part_name_label.include.part_name = imgui.checkbox(
							language.current_language.customization_menu.part_name, config.current_config.large_monster_UI.static.parts.part_name_label.include.part_name);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.parts.part_name_label.include.break_count = imgui.checkbox(
							language.current_language.customization_menu.break_count, config.current_config.large_monster_UI.static.parts.part_name_label.include.break_count);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.parts.part_name_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.parts.part_name_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.parts.part_name_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.parts.part_name_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.parts.part_name_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.part_name_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.parts.part_name_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.parts.part_name_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.parts.part_name_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.static.parts.part_name_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.parts.part_name_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.static.parts.part_name_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.parts.part_name_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.part_name_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.text_label) then
					changed, config.current_config.large_monster_UI.static.parts.text_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.parts.text_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.parts.text_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.parts.text_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.parts.text_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.parts.text_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.parts.text_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.text_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.parts.text_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.parts.text_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.parts.text_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.static.parts.text_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.parts.text_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.static.parts.text_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.parts.text_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.text_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.value_label) then
					changed, config.current_config.large_monster_UI.static.parts.value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.parts.value_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.parts.value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.parts.value_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.parts.value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.parts.value_label.offset.y, 0.1, -screen.height, screen.height,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.parts.value_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.value_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.parts.value_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.parts.value_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.parts.value_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
								config.current_config.large_monster_UI.static.parts.value_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.parts.value_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
								config.current_config.large_monster_UI.static.parts.value_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.parts.value_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.value_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.percentage_label) then
					changed, config.current_config.large_monster_UI.static.parts.percentage_label.visibility = imgui.checkbox(
						language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.parts.percentage_label.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					-- add text format

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.parts.percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.parts.percentage_label.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.parts.percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.parts.percentage_label.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.color) then
						changed, config.current_config.large_monster_UI.static.parts.percentage_label.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.percentage_label.color, customization_menu.color_picker_flags);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.shadow) then
						changed, config.current_config.large_monster_UI.static.parts.percentage_label.shadow.visibility = imgui.checkbox(
							language.current_language.customization_menu.visible, config.current_config.large_monster_UI.static.parts.percentage_label.shadow.visibility);
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						if imgui.tree_node(language.current_language.customization_menu.offset) then
							changed, config.current_config.large_monster_UI.static.parts.percentage_label.shadow.offset.x = imgui.drag_float(
								language.current_language.customization_menu.x, config.current_config.large_monster_UI.static.parts.percentage_label.shadow.offset.x, 0.1, -screen.width,
								screen.width, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							changed, config.current_config.large_monster_UI.static.parts.percentage_label.shadow.offset.y = imgui.drag_float(
								language.current_language.customization_menu.y, config.current_config.large_monster_UI.static.parts.percentage_label.shadow.offset.y, 0.1, -screen.height,
								screen.height, "%.1f");
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.color) then
							changed, config.current_config.large_monster_UI.static.parts.percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.percentage_label.shadow.color, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.bar) then
					changed, config.current_config.large_monster_UI.static.parts.bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
						config.current_config.large_monster_UI.static.parts.bar.visibility);
					config_changed = config_changed or changed;
					large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

					if imgui.tree_node(language.current_language.customization_menu.offset) then
						changed, config.current_config.large_monster_UI.static.parts.bar.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
							config.current_config.large_monster_UI.static.parts.bar.offset.x, 0.1, -screen.width, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.parts.bar.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
							config.current_config.large_monster_UI.static.parts.bar.offset.y, 0.1, -screen.height, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.size) then
						changed, config.current_config.large_monster_UI.static.parts.bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
							config.current_config.large_monster_UI.static.parts.bar.size.width, 0.1, 0, screen.width, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						changed, config.current_config.large_monster_UI.static.parts.bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
							config.current_config.large_monster_UI.static.parts.bar.size.height, 0.1, 0, screen.height, "%.1f");
						config_changed = config_changed or changed;
						large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

						imgui.tree_pop();
					end

					if imgui.tree_node(language.current_language.customization_menu.colors) then
						if imgui.tree_node(language.current_language.customization_menu.foreground) then
							changed, config.current_config.large_monster_UI.static.parts.bar.colors.foreground = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.bar.colors.foreground, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						if imgui.tree_node(language.current_language.customization_menu.background) then
							changed, config.current_config.large_monster_UI.static.parts.bar.colors.background = imgui.color_picker_argb("", config.current_config.large_monster_UI.static.parts.bar.colors.background, customization_menu.color_picker_flags);
							config_changed = config_changed or changed;
							large_monster_static_UI_changed = large_monster_static_UI_changed or changed;

							imgui.tree_pop();
						end

						imgui.tree_pop();
					end

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if large_monster_static_UI_changed then
				for _, monster in pairs(large_monster.list) do
					large_monster.init_static_UI(monster);
				end
			end

			imgui.tree_pop();
		end

		imgui.tree_pop();
	end

	if imgui.tree_node(language.current_language.customization_menu.time_UI) then
		changed, config.current_config.time_UI.enabled = imgui.checkbox(language.current_language.customization_menu.enabled, config.current_config.time_UI.enabled);
		config_changed = config_changed or changed;

		if imgui.tree_node(language.current_language.customization_menu.position) then
			changed, config.current_config.time_UI.position.x = imgui.drag_float(language.current_language.customization_menu.x, config.current_config.time_UI.position.x,
				0.1, 0, screen.width, "%.1f");
			config_changed = config_changed or changed;

			changed, config.current_config.time_UI.position.y = imgui.drag_float(language.current_language.customization_menu.y, config.current_config.time_UI.position.y,
				0.1, 0, screen.height, "%.1f");
			config_changed = config_changed or changed;

			changed, customization_menu.time_UI_anchor_index = imgui.combo(language.current_language.customization_menu.anchor, customization_menu.time_UI_anchor_index,
				customization_menu.displayed_anchor_types);
			config_changed = config_changed or changed;
			if changed then
				config.current_config.time_UI.position.anchor =
					customization_menu.anchor_types[customization_menu.time_UI_anchor_index];
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.time_label) then
			changed, config.current_config.time_UI.time_label.visibility =
				imgui.checkbox(language.current_language.customization_menu.visible, config.current_config.time_UI.time_label.visibility);
			config_changed = config_changed or changed;

			-- add text format

			if imgui.tree_node(language.current_language.customization_menu.offset) then
				changed, config.current_config.time_UI.time_label.offset.x =
					imgui.drag_float(language.current_language.customization_menu.x, config.current_config.time_UI.time_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
				config_changed = config_changed or changed;

				changed, config.current_config.time_UI.time_label.offset.y =
					imgui.drag_float(language.current_language.customization_menu.y, config.current_config.time_UI.time_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
				config_changed = config_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.color) then
				changed, config.current_config.time_UI.time_label.color = imgui.color_picker_argb("", config.current_config.time_UI.time_label.color, customization_menu.color_picker_flags);
				config_changed = config_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.shadow) then
				changed, config.current_config.time_UI.time_label.shadow.visibility =
					imgui.checkbox(language.current_language.customization_menu.visible, config.current_config.time_UI.time_label.shadow.visibility);
				config_changed = config_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.time_UI.time_label.shadow.offset.x =
						imgui.drag_float(language.current_language.customization_menu.x, config.current_config.time_UI.time_label.shadow.offset.x, 0.1, -screen.width, screen.width,
							"%.1f");
					config_changed = config_changed or changed;

					changed, config.current_config.time_UI.time_label.shadow.offset.y =
						imgui.drag_float(language.current_language.customization_menu.y, config.current_config.time_UI.time_label.shadow.offset.y, 0.1, -screen.height,
							screen.height, "%.1f");
					config_changed = config_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.time_UI.time_label.shadow.color = imgui.color_picker_argb("", config.current_config.time_UI.time_label.shadow.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end
			imgui.tree_pop();
		end

		imgui.tree_pop();
	end

	if imgui.tree_node(language.current_language.customization_menu.damage_meter_UI) then
		local damage_meter_UI_changed = false;

		changed, config.current_config.damage_meter_UI.enabled = imgui.checkbox(language.current_language.customization_menu.enabled,
			config.current_config.damage_meter_UI.enabled);
		config_changed = config_changed or changed;
		damage_meter_UI_changed = damage_meter_UI_changed or changed;

		if imgui.tree_node(language.current_language.customization_menu.settings) then
			changed, config.current_config.damage_meter_UI.settings.hide_module_if_total_damage_is_zero = imgui.checkbox(
				language.current_language.customization_menu.hide_module_if_total_damage_is_zero,
				config.current_config.damage_meter_UI.settings.hide_module_if_total_damage_is_zero);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			changed, config.current_config.damage_meter_UI.settings.hide_player_if_player_damage_is_zero = imgui.checkbox(
				language.current_language.customization_menu.hide_player_if_player_damage_is_zero,
				config.current_config.damage_meter_UI.settings.hide_player_if_player_damage_is_zero);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			changed, config.current_config.damage_meter_UI.settings.hide_total_if_total_damage_is_zero = imgui.checkbox(
				language.current_language.customization_menu.hide_total_if_total_damage_is_zero, config.current_config.damage_meter_UI.settings.hide_total_if_total_damage_is_zero);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			changed, config.current_config.damage_meter_UI.settings.total_damage_offset_is_relative = imgui.checkbox(
				language.current_language.customization_menu.total_damage_offset_is_relative, config.current_config.damage_meter_UI.settings.total_damage_offset_is_relative);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			changed, customization_menu.damage_meter_UI_orientation_index = imgui.combo(language.current_language.customization_menu.orientation,
				customization_menu.damage_meter_UI_orientation_index, customization_menu.displayed_orientation_types);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			if changed then
				config.current_config.damage_meter_UI.settings.orientation =
					customization_menu.orientation_types[customization_menu.damage_meter_UI_orientation_index];
			end

			changed, customization_menu.damage_meter_UI_highlighted_bar_index =
				imgui.combo(language.current_language.customization_menu.highlighted_bar, customization_menu.damage_meter_UI_highlighted_bar_index,
					customization_menu.displayed_damage_meter_UI_highlighted_bar_types);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			if changed then
				config.current_config.damage_meter_UI.settings.highlighted_bar =
					customization_menu.damage_meter_UI_highlighted_bar_types[customization_menu.damage_meter_UI_highlighted_bar_index];
			end

			changed, customization_menu.damage_meter_UI_damage_bar_relative_index =
				imgui.combo(language.current_language.customization_menu.damage_bars_are_relative_to, customization_menu.damage_meter_UI_damage_bar_relative_index,
					customization_menu.displayed_damage_meter_UI_damage_bar_relative_types);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			if changed then
				config.current_config.damage_meter_UI.settings.damage_bar_relative_to =
					customization_menu.damage_meter_UI_damage_bar_relative_types[customization_menu.damage_meter_UI_damage_bar_relative_index];
			end

			changed, customization_menu.damage_meter_UI_my_damage_bar_location_index =
				imgui.combo(language.current_language.customization_menu.my_damage_bar_location, customization_menu.damage_meter_UI_my_damage_bar_location_index,
					customization_menu.displayed_damage_meter_UI_my_damage_bar_location_types);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			if changed then
				config.current_config.damage_meter_UI.settings.my_damage_bar_location =
					customization_menu.damage_meter_UI_my_damage_bar_location_types[customization_menu.damage_meter_UI_my_damage_bar_location_index];
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.tracked_monster_types) then
			local tracked_monster_types_changed = false;
			changed, config.current_config.damage_meter_UI.tracked_monster_types.small_monsters = imgui.checkbox(
				language.current_language.customization_menu.small_monsters, config.current_config.damage_meter_UI.tracked_monster_types.small_monsters);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			tracked_monster_types_changed = tracked_monster_types_changed or changed;

			changed, config.current_config.damage_meter_UI.tracked_monster_types.large_monsters = imgui.checkbox(
				language.current_language.customization_menu.large_monsters, config.current_config.damage_meter_UI.tracked_monster_types.large_monsters);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			tracked_monster_types_changed = tracked_monster_types_changed or changed;

			if tracked_monster_types_changed then
				for player_id, _player in pairs(player.list) do
					_player.update_display(player);
				end
				player.update_display(player.total);
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.tracked_damage_types) then
			local tracked_damage_types_changed = false;
			changed, config.current_config.damage_meter_UI.tracked_damage_types.player_damage =
				imgui.checkbox(language.current_language.customization_menu.player_damage, config.current_config.damage_meter_UI.tracked_damage_types.player_damage);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			tracked_damage_types_changed = tracked_damage_types_changed or changed;

			changed, config.current_config.damage_meter_UI.tracked_damage_types.bomb_damage = imgui.checkbox(language.current_language.customization_menu.bomb_damage,
				config.current_config.damage_meter_UI.tracked_damage_types.bomb_damage);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			tracked_damage_types_changed = tracked_damage_types_changed or changed;

			changed, config.current_config.damage_meter_UI.tracked_damage_types.kunai_damage =
				imgui.checkbox(language.current_language.customization_menu.kunai_damage, config.current_config.damage_meter_UI.tracked_damage_types.kunai_damage);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			tracked_damage_types_changed = tracked_damage_types_changed or changed;

			changed, config.current_config.damage_meter_UI.tracked_damage_types.installation_damage = imgui.checkbox(
				language.current_language.customization_menu.installation_damage, config.current_config.damage_meter_UI.tracked_damage_types.installation_damage);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			tracked_damage_types_changed = tracked_damage_types_changed or changed;

			changed, config.current_config.damage_meter_UI.tracked_damage_types.otomo_damage =
				imgui.checkbox(language.current_language.customization_menu.otomo_damage, config.current_config.damage_meter_UI.tracked_damage_types.otomo_damage);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			tracked_damage_types_changed = tracked_damage_types_changed or changed;

			changed, config.current_config.damage_meter_UI.tracked_damage_types.monster_damage =
				imgui.checkbox(language.current_language.customization_menu.monster_damage, config.current_config.damage_meter_UI.tracked_damage_types.monster_damage);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			tracked_damage_types_changed = tracked_damage_types_changed or changed;

			if tracked_damage_types_changed then
				for player_id, _player in pairs(player.list) do
					player.update_display(_player);
				end
				player.update_display(player.total);
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.spacing) then
			changed, config.current_config.damage_meter_UI.spacing.x =
				imgui.drag_float(language.current_language.customization_menu.x, config.current_config.damage_meter_UI.spacing.x, 0.1, -screen.width, screen.width, "%.1f");
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			changed, config.current_config.damage_meter_UI.spacing.y =
				imgui.drag_float(language.current_language.customization_menu.y, config.current_config.damage_meter_UI.spacing.y, 0.1, -screen.height, screen.height, "%.1f");
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.position) then
			changed, config.current_config.damage_meter_UI.position.x =
				imgui.drag_float(language.current_language.customization_menu.x, config.current_config.damage_meter_UI.position.x, 0.1, 0, screen.width, "%.1f");
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			changed, config.current_config.damage_meter_UI.position.y =
				imgui.drag_float(language.current_language.customization_menu.y, config.current_config.damage_meter_UI.position.y, 0.1, 0, screen.height, "%.1f");
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			changed, customization_menu.damage_meter_UI_anchor_index = imgui.combo(language.current_language.customization_menu.anchor,
				customization_menu.damage_meter_UI_anchor_index, customization_menu.displayed_anchor_types);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			if changed then
				config.current_config.damage_meter_UI.position.anchor =
					customization_menu.anchor_types[customization_menu.damage_meter_UI_anchor_index];
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.sorting) then
			changed, customization_menu.damage_meter_UI_sort_type_index = imgui.combo(language.current_language.customization_menu.type,
				customization_menu.damage_meter_UI_sort_type_index, customization_menu.displayed_damage_meter_UI_sorting_types);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;
			if changed then
				config.current_config.damage_meter_UI.sorting.type =
					customization_menu.damage_meter_UI_sorting_types[customization_menu.damage_meter_UI_sort_type_index];
			end

			changed, config.current_config.damage_meter_UI.sorting.reversed_order =
				imgui.checkbox(language.current_language.customization_menu.reversed_order, config.current_config.damage_meter_UI.sorting.reversed_order);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.player_name_label) then
			changed, config.current_config.damage_meter_UI.player_name_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
				config.current_config.damage_meter_UI.player_name_label.visibility);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			if imgui.tree_node(language.current_language.customization_menu.include) then
				if imgui.tree_node(language.current_language.customization_menu.me) then
					changed, config.current_config.damage_meter_UI.player_name_label.include.myself.hunter_rank = imgui.checkbox(
						language.current_language.customization_menu.hunter_rank, config.current_config.damage_meter_UI.player_name_label.include.myself.hunter_rank);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.player_name_label.include.myself.word_player = imgui.checkbox(
						language.current_language.customization_menu.word_player, config.current_config.damage_meter_UI.player_name_label.include.myself.word_player);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.player_name_label.include.myself.player_id = imgui.checkbox(
						language.current_language.customization_menu.player_id, config.current_config.damage_meter_UI.player_name_label.include.myself.player_id);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.player_name_label.include.myself.player_name = imgui.checkbox(
						language.current_language.customization_menu.player_name, config.current_config.damage_meter_UI.player_name_label.include.myself.player_name);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.other_players) then
					changed, config.current_config.damage_meter_UI.player_name_label.include.others.hunter_rank = imgui.checkbox(
						language.current_language.customization_menu.hunter_rank, config.current_config.damage_meter_UI.player_name_label.include.others.hunter_rank);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.player_name_label.include.others.word_player = imgui.checkbox(
						language.current_language.customization_menu.word_player, config.current_config.damage_meter_UI.player_name_label.include.others.word_player);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.player_name_label.include.others.player_id = imgui.checkbox(
						language.current_language.customization_menu.player_id, config.current_config.damage_meter_UI.player_name_label.include.others.player_id);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.player_name_label.include.others.player_name = imgui.checkbox(
						language.current_language.customization_menu.player_name, config.current_config.damage_meter_UI.player_name_label.include.others.player_name);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.offset) then
				changed, config.current_config.damage_meter_UI.player_name_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.damage_meter_UI.player_name_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				changed, config.current_config.damage_meter_UI.player_name_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.damage_meter_UI.player_name_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.color) then
				changed, config.current_config.damage_meter_UI.player_name_label.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.player_name_label.color, customization_menu.color_picker_flags);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.shadow) then
				changed, config.current_config.damage_meter_UI.player_name_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.damage_meter_UI.player_name_label.shadow.visibility);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.damage_meter_UI.player_name_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.damage_meter_UI.player_name_label.shadow.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.player_name_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.damage_meter_UI.player_name_label.shadow.offset.y, 0.1, -screen.height, screen.height,
						"%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.damage_meter_UI.player_name_label.shadow.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.player_name_label.shadow.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.damage_value_label) then
			changed, config.current_config.damage_meter_UI.damage_value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
				config.current_config.damage_meter_UI.damage_value_label.visibility);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			-- add text format

			if imgui.tree_node(language.current_language.customization_menu.offset) then
				changed, config.current_config.damage_meter_UI.damage_value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.damage_meter_UI.damage_value_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				changed, config.current_config.damage_meter_UI.damage_value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.damage_meter_UI.damage_value_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.color) then
				changed, config.current_config.damage_meter_UI.damage_value_label.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.damage_value_label.color, customization_menu.color_picker_flags);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.shadow) then
				changed, config.current_config.damage_meter_UI.damage_value_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.damage_meter_UI.damage_value_label.shadow.visibility);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.damage_meter_UI.damage_value_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.damage_meter_UI.damage_value_label.shadow.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.damage_value_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.damage_meter_UI.damage_value_label.shadow.offset.y, 0.1, -screen.height, screen.height,
						"%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.damage_meter_UI.damage_value_label.shadow.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.damage_value_label.shadow.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.damage_percentage_label) then
			changed, config.current_config.damage_meter_UI.damage_percentage_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
				config.current_config.damage_meter_UI.damage_percentage_label.visibility);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			-- add text format

			if imgui.tree_node(language.current_language.customization_menu.offset) then
				changed, config.current_config.damage_meter_UI.damage_percentage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.damage_meter_UI.damage_percentage_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				changed, config.current_config.damage_meter_UI.damage_percentage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.damage_meter_UI.damage_percentage_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.color) then
				changed, config.current_config.damage_meter_UI.damage_percentage_label.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.damage_percentage_label.color, customization_menu.color_picker_flags);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.shadow) then
				changed, config.current_config.damage_meter_UI.damage_percentage_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.damage_meter_UI.damage_percentage_label.shadow.visibility);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.damage_meter_UI.damage_percentage_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.damage_meter_UI.damage_percentage_label.shadow.offset.x, 0.1, -screen.width, screen.width,
						"%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.damage_percentage_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.damage_meter_UI.damage_percentage_label.shadow.offset.y, 0.1, -screen.height, screen.height,
						"%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.damage_meter_UI.damage_percentage_label.shadow.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.damage_percentage_label.shadow.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.total_damage_label) then
			changed, config.current_config.damage_meter_UI.total_damage_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
				config.current_config.damage_meter_UI.total_damage_label.visibility);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			-- add text format

			if imgui.tree_node(language.current_language.customization_menu.offset) then
				changed, config.current_config.damage_meter_UI.total_damage_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.damage_meter_UI.total_damage_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				changed, config.current_config.damage_meter_UI.total_damage_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.damage_meter_UI.total_damage_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.color) then
				changed, config.current_config.damage_meter_UI.total_damage_label.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.total_damage_label.color, customization_menu.color_picker_flags);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.shadow) then
				changed, config.current_config.damage_meter_UI.total_damage_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.damage_meter_UI.total_damage_label.shadow.visibility);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.damage_meter_UI.total_damage_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.damage_meter_UI.total_damage_label.shadow.offset.x, 0.1, -screen.width, screen.width, "%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.total_damage_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.damage_meter_UI.total_damage_label.shadow.offset.y, 0.1, -screen.height, screen.height,
						"%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.damage_meter_UI.total_damage_label.shadow.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.total_damage_label.shadow.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.total_damage_value_label) then
			changed, config.current_config.damage_meter_UI.total_damage_value_label.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
				config.current_config.damage_meter_UI.total_damage_value_label.visibility);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			-- add text format

			if imgui.tree_node(language.current_language.customization_menu.offset) then
				changed, config.current_config.damage_meter_UI.total_damage_value_label.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.damage_meter_UI.total_damage_value_label.offset.x, 0.1, -screen.width, screen.width, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				changed, config.current_config.damage_meter_UI.total_damage_value_label.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.damage_meter_UI.total_damage_value_label.offset.y, 0.1, -screen.height, screen.height, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.color) then
				changed, config.current_config.damage_meter_UI.total_damage_value_label.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.total_damage_value_label.color, customization_menu.color_picker_flags);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.shadow) then
				changed, config.current_config.damage_meter_UI.total_damage_value_label.shadow.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
					config.current_config.damage_meter_UI.total_damage_value_label.shadow.visibility);
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				if imgui.tree_node(language.current_language.customization_menu.offset) then
					changed, config.current_config.damage_meter_UI.total_damage_value_label.shadow.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
						config.current_config.damage_meter_UI.total_damage_value_label.shadow.offset.x, 0.1, -screen.width, screen.width,
						"%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					changed, config.current_config.damage_meter_UI.total_damage_value_label.shadow.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
						config.current_config.damage_meter_UI.total_damage_value_label.shadow.offset.y, 0.1, -screen.height,
						screen.height, "%.1f");
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.color) then
					changed, config.current_config.damage_meter_UI.total_damage_value_label.shadow.color = imgui.color_picker_argb("", config.current_config.damage_meter_UI.total_damage_value_label.shadow.color, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.damage_bar) then
			changed, config.current_config.damage_meter_UI.damage_bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
				config.current_config.damage_meter_UI.damage_bar.visibility);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			if imgui.tree_node(language.current_language.customization_menu.offset) then
				changed, config.current_config.damage_meter_UI.damage_bar.offset.x =
					imgui.drag_float(language.current_language.customization_menu.x, config.current_config.damage_meter_UI.damage_bar.offset.x, 0.1, -screen.width, screen.width,
						"%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				changed, config.current_config.damage_meter_UI.damage_bar.offset.y =
					imgui.drag_float(language.current_language.customization_menu.y, config.current_config.damage_meter_UI.damage_bar.offset.y, 0.1, -screen.height,
						screen.height, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.size) then
				changed, config.current_config.damage_meter_UI.damage_bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
					config.current_config.damage_meter_UI.damage_bar.size.width, 0.1, 0, screen.width, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				changed, config.current_config.damage_meter_UI.damage_bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
					config.current_config.damage_meter_UI.damage_bar.size.height, 0.1, 0, screen.height, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.colors) then
				if imgui.tree_node(language.current_language.customization_menu.foreground) then
					changed, config.current_config.damage_meter_UI.damage_bar.colors.foreground = imgui.color_picker_argb("", config.current_config.damage_meter_UI.damage_bar.colors.foreground, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.background) then
					changed, config.current_config.damage_meter_UI.damage_bar.colors.background = imgui.color_picker_argb("", config.current_config.damage_meter_UI.damage_bar.colors.background, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if imgui.tree_node(language.current_language.customization_menu.highlighted_damage_bar) then
			changed, config.current_config.damage_meter_UI.highlighted_damage_bar.visibility = imgui.checkbox(language.current_language.customization_menu.visible,
				config.current_config.damage_meter_UI.highlighted_damage_bar.visibility);
			config_changed = config_changed or changed;
			damage_meter_UI_changed = damage_meter_UI_changed or changed;

			if imgui.tree_node(language.current_language.customization_menu.offset) then
				changed, config.current_config.damage_meter_UI.highlighted_damage_bar.offset.x = imgui.drag_float(language.current_language.customization_menu.x,
					config.current_config.damage_meter_UI.highlighted_damage_bar.offset.x, 0.1, -screen.width, screen.width, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				changed, config.current_config.damage_meter_UI.highlighted_damage_bar.offset.y = imgui.drag_float(language.current_language.customization_menu.y,
					config.current_config.damage_meter_UI.highlighted_damage_bar.offset.y, 0.1, -screen.height, screen.height, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.size) then
				changed, config.current_config.damage_meter_UI.highlighted_damage_bar.size.width = imgui.drag_float(language.current_language.customization_menu.width,
					config.current_config.damage_meter_UI.highlighted_damage_bar.size.width, 0.1, 0, screen.width, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				changed, config.current_config.damage_meter_UI.highlighted_damage_bar.size.height = imgui.drag_float(language.current_language.customization_menu.height,
					config.current_config.damage_meter_UI.highlighted_damage_bar.size.height, 0.1, 0, screen.height, "%.1f");
				config_changed = config_changed or changed;
				damage_meter_UI_changed = damage_meter_UI_changed or changed;

				imgui.tree_pop();
			end

			if imgui.tree_node(language.current_language.customization_menu.colors) then
				if imgui.tree_node(language.current_language.customization_menu.foreground) then
					changed, config.current_config.damage_meter_UI.highlighted_damage_bar.colors.foreground = imgui.color_picker_argb("", config.current_config.damage_meter_UI.highlighted_damage_bar.colors.foreground, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				if imgui.tree_node(language.current_language.customization_menu.background) then
					changed, config.current_config.damage_meter_UI.highlighted_damage_bar.colors.background = imgui.color_picker_argb("", config.current_config.damage_meter_UI.highlighted_damage_bar.colors.background, customization_menu.color_picker_flags);
					config_changed = config_changed or changed;
					damage_meter_UI_changed = damage_meter_UI_changed or changed;

					imgui.tree_pop();
				end

				imgui.tree_pop();
			end

			imgui.tree_pop();
		end

		if damage_meter_UI_changed then
			for _, _player in pairs(player.list) do
				player.init_UI(_player);
			end
		end

		imgui.tree_pop();
	end

	imgui.end_window();

	imgui.pop_font(customization_menu.font);

	if config_changed then
		config.save();
	end
end

function customization_menu.init_module()
	table_helpers = require("MHR_Overlay.Misc.table_helpers");
	language = require("MHR_Overlay.Misc.language");
	config = require("MHR_Overlay.Misc.config");
	screen = require("MHR_Overlay.Game_Handler.screen");
	player = require("MHR_Overlay.Damage_Meter.player");
	small_monster = require("MHR_Overlay.Monsters.small_monster");
	large_monster = require("MHR_Overlay.Monsters.large_monster");
	part_names = require("MHR_Overlay.Misc.part_names");

	customization_menu.init();
end

return customization_menu;