# Set your WordPress API URL, username, and password
$apiUrl = "https://kmetsa.webhosting.tptlive.ee/KMWP/wp-json/wp/v2/posts"
$username = ""
$password = ""

$csvFilePath = "C:\Users\Kaido Metsa\Desktop\WP_API\MyData.csv"


$csvData = Import-Csv -Path $csvFilePath


$pair = "${username}:${password}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64AuthInfo = [System.Convert]::ToBase64String($bytes)

foreach ($row in $csvData) {
    $postTitle = $row.post_title
    $postContent = $row.post_content
    $postCategory = $row.post_category

    
    $post = @{
        title   = $postTitle
        content = $postContent
        status  = 'publish'
        categories = @($postCategory)
    }
    $json = $post | ConvertTo-Json

    try {
        $response = Invoke-WebRequest -Uri $apiUrl -Method POST -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Body $json
        Write-Host "Post created: $($response.Content)"
    } catch {
        Write-Host "Error creating post: $($_.Exception.Message)"
        Write-Host "Request details: $json"
    }
}
