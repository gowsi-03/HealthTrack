# ===========================================================================
# Export-DatabaseSeed.ps1
# Run this script before `git push` whenever you add new data in the browser UI
# so that `Data/HealthTrackSeedData.sql` is updated with your latest database rows.
# ===========================================================================
$ErrorActionPreference = "Stop"
$connStr = "Server=.;Database=HealthTrackDB;Trusted_Connection=True;TrustServerCertificate=True;"
$conn = New-Object System.Data.SqlClient.SqlConnection($connStr)
$conn.Open()

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine("-- ===========================================================================")
[void]$sb.AppendLine("-- HealthTrack Automatic Database Seed Backup Script")
[void]$sb.AppendLine("-- Auto-injected on application startup by DbInitializer.cs")
[void]$sb.AppendLine("-- ===========================================================================")
[void]$sb.AppendLine("SET NOCOUNT ON;")
[void]$sb.AppendLine("")

function Format-SqlValue($val) {
    if ($null -eq $val -or $val -is [System.DBNull]) { return "NULL" }
    if ($val -is [bool]) { return $(if ($val) { "1" } else { "0" }) }
    if ($val -is [DateTime]) { return "'" + $val.ToString("yyyy-MM-ddTHH:mm:ss.fff") + "'" }
    if ($val -is [DateTimeOffset]) { return "'" + $val.ToString("yyyy-MM-ddTHH:mm:ss.fffzzz") + "'" }
    if ($val -is [int] -or $val -is [long] -or $val -is [int16] -or $val -is [byte]) { return $val.ToString() }
    if ($val -is [double] -or $val -is [float] -or $val -is [decimal]) {
        return $val.ToString([System.Globalization.CultureInfo]::InvariantCulture)
    }
    $escaped = $val.ToString().Replace("'", "''")
    return "N'$escaped'"
}

function Export-Table($tableName, $hasIdentity, $pkCol, $orderBy) {
    [void]$sb.AppendLine("-- ---------------------------------------------------------------------------")
    [void]$sb.AppendLine("-- Table: [$tableName]")
    [void]$sb.AppendLine("-- ---------------------------------------------------------------------------")

    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "SELECT * FROM [$tableName]" + $(if ($orderBy) { " ORDER BY $orderBy" } else { "" })
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter($cmd)
    $dt = New-Object System.Data.DataTable
    [void]$adapter.Fill($dt)

    if ($dt.Rows.Count -eq 0) { return }

    if ($hasIdentity) { [void]$sb.AppendLine("SET IDENTITY_INSERT [$tableName] ON;") }

    $colNames = @()
    foreach ($col in $dt.Columns) { $colNames += "[" + $col.ColumnName + "]" }
    $colList = $colNames -join ", "

    foreach ($row in $dt.Rows) {
        $vals = @()
        foreach ($col in $dt.Columns) { $vals += Format-SqlValue $row[$col.ColumnName] }
        $valList = $vals -join ", "

        if ($pkCol -eq "CompositeUserRole") {
            $uId = Format-SqlValue $row["UserId"]
            $rId = Format-SqlValue $row["RoleId"]
            [void]$sb.AppendLine("IF NOT EXISTS (SELECT 1 FROM [$tableName] WHERE [UserId] = $uId AND [RoleId] = $rId)")
            [void]$sb.AppendLine("    INSERT INTO [$tableName] ($colList) VALUES ($valList);")
        }
        else {
            $pkVal = Format-SqlValue $row[$pkCol]
            [void]$sb.AppendLine("IF NOT EXISTS (SELECT 1 FROM [$tableName] WHERE [$pkCol] = $pkVal)")
            [void]$sb.AppendLine("    INSERT INTO [$tableName] ($colList) VALUES ($valList);")
        }
    }

    if ($hasIdentity) { [void]$sb.AppendLine("SET IDENTITY_INSERT [$tableName] OFF;") }
    [void]$sb.AppendLine("")
}

Export-Table "AspNetRoles" $false "Id" "[Id]"

[void]$sb.AppendLine("-- ---------------------------------------------------------------------------")
[void]$sb.AppendLine("-- Table: [AspNetUsers] (Trainers & Admins first, then Clients)")
[void]$sb.AppendLine("-- ---------------------------------------------------------------------------")
$cmdUsers = $conn.CreateCommand()
$cmdUsers.CommandText = "SELECT * FROM [AspNetUsers] ORDER BY CASE WHEN [TrainerId] IS NULL THEN 0 ELSE 1 END, [Id]"
$adapterUsers = New-Object System.Data.SqlClient.SqlDataAdapter($cmdUsers)
$dtUsers = New-Object System.Data.DataTable
[void]$adapterUsers.Fill($dtUsers)

$uColNames = @()
foreach ($col in $dtUsers.Columns) { $uColNames += "[" + $col.ColumnName + "]" }
$uColList = $uColNames -join ", "

foreach ($row in $dtUsers.Rows) {
    $vals = @()
    foreach ($col in $dtUsers.Columns) { $vals += Format-SqlValue $row[$col.ColumnName] }
    $valList = $vals -join ", "
    $pkVal = Format-SqlValue $row["Id"]
    $emailVal = Format-SqlValue $row["Email"]
    [void]$sb.AppendLine("IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = $pkVal OR [Email] = $emailVal)")
    [void]$sb.AppendLine("    INSERT INTO [AspNetUsers] ($uColList) VALUES ($valList);")
}
[void]$sb.AppendLine("")

Export-Table "AspNetUserRoles" $false "CompositeUserRole" "[UserId], [RoleId]"
Export-Table "PlatformSettings" $true "Id" "[Id]"
Export-Table "WorkoutTemplates" $true "Id" "[Id]"
Export-Table "DietTemplates" $true "Id" "[Id]"
Export-Table "WorkoutPlans" $true "Id" "[Id]"
Export-Table "WorkoutExercises" $true "Id" "[Id]"
Export-Table "DietPlans" $true "Id" "[Id]"
Export-Table "MealItems" $true "Id" "[Id]"
Export-Table "Appointments" $true "Id" "[Id]"
Export-Table "HealthLogs" $true "Id" "[Id]"
Export-Table "Notifications" $true "Id" "[Id]"

$conn.Close()

$outPath = Join-Path $PSScriptRoot "Data\HealthTrackSeedData.sql"
[System.IO.File]::WriteAllText($outPath, $sb.ToString(), [System.Text.Encoding]::UTF8)
Write-Host "Successfully exported HealthTrackDB seed data to: $outPath" -ForegroundColor Green
