param([int]$Port = 8000)

# Petit serveur web local (sans Python, sans installation) pour Le Peuple Vert.
# Sert uniquement le dossier où se trouve ce fichier.
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootSep = $root.TrimEnd('\') + '\'

$mime = @{
  ".html" = "text/html; charset=utf-8"; ".htm" = "text/html; charset=utf-8"
  ".js" = "application/javascript; charset=utf-8"; ".css" = "text/css; charset=utf-8"
  ".json" = "application/json; charset=utf-8"; ".svg" = "image/svg+xml"
  ".png" = "image/png"; ".jpg" = "image/jpeg"; ".jpeg" = "image/jpeg"
  ".gif" = "image/gif"; ".webp" = "image/webp"; ".ico" = "image/x-icon"
  ".mp3" = "audio/mpeg"; ".wav" = "audio/wav"; ".mp4" = "video/mp4"; ".pdf" = "application/pdf"
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
try { $listener.Start() }
catch {
  Write-Host ""
  Write-Host "Impossible de demarrer le serveur sur le port $Port :" -ForegroundColor Red
  Write-Host $_.Exception.Message -ForegroundColor Red
  Write-Host "(Le port est peut-etre deja utilise : fermez l'autre fenetre noire du jeu puis relancez.)"
  exit 1
}

Write-Host "Serveur pret sur http://localhost:$Port/"
Write-Host "LAISSEZ CETTE FENETRE OUVERTE pendant tout l'atelier (la reduire, mais ne pas la fermer)."

while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  try {
    $rel = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart('/'))
    if ($rel -eq "") { $rel = "peuple-vert-v6.html" }
    $full = [System.IO.Path]::GetFullPath((Join-Path $root $rel))
    if (-not $full.StartsWith($rootSep, [StringComparison]::OrdinalIgnoreCase) -or -not (Test-Path -LiteralPath $full -PathType Leaf)) {
      $ctx.Response.StatusCode = 404
    } else {
      $bytes = [System.IO.File]::ReadAllBytes($full)
      $ext = [System.IO.Path]::GetExtension($full).ToLower()
      $ctx.Response.ContentType = $(if ($mime.ContainsKey($ext)) { $mime[$ext] } else { "application/octet-stream" })
      $ctx.Response.Headers.Add("Cache-Control", "no-cache")
      $ctx.Response.ContentLength64 = $bytes.Length
      $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    }
  } catch {
    try { $ctx.Response.StatusCode = 500 } catch {}
  } finally {
    try { $ctx.Response.Close() } catch {}
  }
}
