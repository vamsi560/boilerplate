# validate-terraform-boilerplate.ps1

# Function to read boilerplate rules from a JSON file
function Get-BoilerplateRules {
    $rulesJson = Get-Content -Path "boilerplate-rules.json" -Raw
    return ConvertFrom-Json $rulesJson
}

# Function to check a single file against boilerplate rules
function Check-TerraformFile {
    param (
        [string]$filePath,
        $rules
    )

    $content = Get-Content -Path $filePath
    $violations = @()

    foreach ($rule in $rules) {
        $lineNumber = 1
        foreach ($line in $content) {
            if ($line -notmatch $rule.pattern) {
                $violations += @{
                    Line = $lineNumber
                    Rule = $rule.name
                    Message = $rule.message
                }
            }
            $lineNumber++
        }
    }

    return $violations
}

# Function to add comments to a file based on violations
function Add-CommentsToFile {
    param (
        [string]$filePath,
        $violations
    )

    $content = Get-Content -Path $filePath
    $newContent = @()

    for ($i = 0; $i -lt $content.Length; $i++) {
        $lineViolations = $violations | Where-Object { $_.Line -eq ($i + 1) }
        if ($lineViolations) {
            foreach ($violation in $lineViolations) {
                $newContent += "# VIOLATION: $($violation.Rule) - $($violation.Message)"
            }
        }
        $newContent += $content[$i]
    }

    Set-Content -Path $filePath -Value $newContent
}

# Function to generate a report of all violations
function Generate-Report {
    param (
        $allViolations
    )

    $report = "Terraform Boilerplate Validation Report`n"
    $report += "======================================`n`n"

    foreach ($file in $allViolations.Keys) {
        $report += "File: $file`n"
        foreach ($violation in $allViolations[$file]) {
            $report += "  Line $($violation.Line): $($violation.Rule) - $($violation.Message)`n"
        }
        $report += "`n"
    }

    return $report
}

# Main execution
$rules = Get-BoilerplateRules
$allViolations = @{}

Get-ChildItem -Recurse -Filter "*.tf" | ForEach-Object {
    $violations = Check-TerraformFile -filePath $_.FullName -rules $rules
    if ($violations) {
        $allViolations[$_.FullName] = $violations
        Add-CommentsToFile -filePath $_.FullName -violations $violations
    }
}

$report = Generate-Report -allViolations $allViolations

# Output report (in a real scenario, you'd save this to a file or send via email)
Write-Output $report

# Exit with non-zero code if there were any violations
if ($allViolations.Count -gt 0) {
    exit 1
}
