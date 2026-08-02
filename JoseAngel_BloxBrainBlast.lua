-- Script temporal para detectar remotos
for _, obj in pairs(game:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        print("Remote encontrado:", obj.Parent.Name .. "." .. obj.Name)
    end
end
