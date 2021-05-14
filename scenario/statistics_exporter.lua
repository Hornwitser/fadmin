-- Taken from Clusterio's statistic_exporter plugin

local statistics = {
    "item_production_statistics",
    "fluid_production_statistics",
    "kill_count_statistics",
    "entity_build_count_statistics",
}

local statistics_exporter = {}
function statistics_exporter.export()
    local stats = {
        game_tick = game.tick,
        player_count = #game.connected_players,
        game_flow_statistics = {
            pollution_statistics = {
                input = game.pollution_statistics.input_counts,
                output = game.pollution_statistics.output_counts,
            },
        },
        force_flow_statistics = {}
    }
    for _, force in pairs(game.forces) do
        local flow_statistics = {}
        for _, statName in pairs(statistics) do
            flow_statistics[statName] = {
                input = force[statName].input_counts,
                output = force[statName].output_counts,
            }
        end
        stats.force_flow_statistics[force.name] = flow_statistics
    end


    return stats
end

return statistics_exporter
