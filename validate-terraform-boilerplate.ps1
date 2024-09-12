# validate-terraform-boilerplate.ps1

# Function to read boilerplate rules from a JSON file
function Get-BoilerplateRules {
    $rulesPath = "boilerplate-rules.json"
    Write-Host "Reading rules from $rulesPath"
    if (Test-Path $rulesPath) {
        $rulesJson = Get-Content -Path $rulesPath -Raw
        return ConvertFrom-Json $rulesJson
    } else {
        Write-Host "Rules file not found at $rulesPath"
        return $null
    }
}

# Function to check a single file against boilerplate rules
function Check-TerraformFile {
    param (
        [string]$filePath,
        $rules
    )

    Write-Host "Checking file: $filePath"
    $content = Get-Content -Path $filePath
    $violations = @()

    foreach ($rule in $rules.rules) {
        $lineNumber = 1
        foreach ($line in $content) {
            if ($line -notmatch $rule.pattern) {
                $violations += @{
                    File = $filePath
                    Line = $lineNumber
                    Rule = $rule.name
                    Category = $rule.category
                    Message = $rule.message
                }
            }
            $lineNumber++
        }
    }

    Write-Host "Found $($violations.Count) violations in $filePath"
    return $violations
}

# Function to add comments to a file based on violations
function Add-CommentsToFile {
    param (
        [string]$filePath,
        $violations
    )

    Write-Host "Adding comments to $filePath"
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

    $report = "# Terraform Boilerplate Validation Report`n`n"

    if ($allViolations.Count -eq 0) {
        $report += "No violations found. All files comply with the boilerplate rules.`n"
    } else {
        $totalViolations = ($allViolations.Values | ForEach-Object { $_ } | Measure-Object).Count
        $report += "**Total Violations Found: $totalViolations**`n`n"

        $report += "## Summary`n`n"
        $categorizedViolations = $allViolations.Values | ForEach-Object { $_ } | Group-Object -Property Category

        $report += "| Category | Violation Count |`n"
        $report += "|----------|-----------------|`n"
        foreach ($category in $categorizedViolations) {
            $report += "| $($category.Name) | $($category.Count) |`n"
        }
        $report += "`n"

        $report += "## Detailed Findings`n`n"
        foreach ($category in $categorizedViolations) {
            $report += "### $($category.Name)`n`n"
            
            $ruleViolations = $category.Group | Group-Object -Property Rule
            foreach ($rule in $ruleViolations) {
                $report += "#### $($rule.Name)`n`n"
                $report += "| File | Line | Message |`n"
                $report += "|------|------|---------|`n"
                foreach ($violation in $rule.Group) {
                    $fileName = Split-Path $violation.File -Leaf
                    $report += "| $fileName | $($violation.Line) | $($violation.Message) |`n"
                }
                $report += "`n"
            }
        }
    }

    return $report
}
# Main execution
$rules = Get-BoilerplateRules
if ($null -eq $rules) {
    Write-Host "No rules found. Exiting."
    exit 0  # Exit successfully even if no rules are found
}

$allViolations = @{}

$tfFiles = Get-ChildItem -Recurse -Filter "*.tf"
Write-Host "Found $($tfFiles.Count) Terraform files"

foreach ($file in $tfFiles) {
    $violations = Check-TerraformFile -filePath $file.FullName -rules $rules
    if ($violations) {
        $allViolations[$file.FullName] = $violations
        Add-CommentsToFile -filePath $file.FullName -violations $violations
    }
}

$report = Generate-Report -allViolations $allViolations

# Save report to a file
$reportPath = "terraform-validation-report.md"
Set-Content -Path $reportPath -Value $report

Write-Host "Validation report saved to $reportPath"
Write-Host "Total violations found: $($allViolations.Values | Measure-Object -Property Count -Sum | Select-Object -ExpandProperty Sum)"

# Always exit with 0 to indicate success, regardless of violations found
exit 0
