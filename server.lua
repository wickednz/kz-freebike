local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('kz-freebike:server:GetTaxi', function(source, cb)
    local TaxiCount = 0

    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "taxi" and v.PlayerData.job.onduty then
            TaxiCount = TaxiCount + 1
        end

    end
    cb(TaxiCount)
end)

