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
            # Check if the line matches the rule pattern
            if ($line -match $rule.pattern) {
                # If a match is found, record it as a violation
                $violations += @{
                    File = $filePath
                    Line = $lineNumber
                    Rule = $rule.name
                    Category = $rule.category
                    Message = $rule.message
                    Example = $rule.example  # Include example from rule
                }
            }
            $lineNumber++
        }
    }

    Write-Host "Found $($violations.Count) violations in $filePath"
    return $violations
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

        $report += "| Category | Subcategory | Violation Count |`n"
        $report += "|----------|-------------|-----------------|`n"
        foreach ($category in $categorizedViolations) {
            $subcategories = $category.Group | Group-Object -Property Rule
            $firstSubcategory = $true
            foreach ($subcategory in $subcategories) {
                if ($firstSubcategory) {
                    $report += "| $($category.Name) | $($subcategory.Name) | $($subcategory.Count) |`n"
                    $firstSubcategory = $false
                } else {
                    $report += "| | $($subcategory.Name) | $($subcategory.Count) |`n"
                }
            }
        }
        $report += "`n"

        $report += "## Detailed Findings`n`n"
        foreach ($category in $categorizedViolations) {
            $report += "### $($category.Name)`n`n"
            
            $ruleViolations = $category.Group | Group-Object -Property Rule
            foreach ($rule in $ruleViolations) {
                $report += "#### $($rule.Name)`n`n"
                $report += "| File | Line | Message | Example |`n"
                $report += "|------|------|---------|---------|`n"
                foreach ($violation in $rule.Group) {
                    $fileName = Split-Path $violation.File -Leaf
                    $report += "| $fileName | $($violation.Line) | $($violation.Message) | $($violation.Example) |`n"
                }
                $report += "`n"
            }
        }
    }

    return $report
}
