Feature: Show common information for tooling

  Scenario: Show general help
    When I run `../../bin/sphere-ipinfo-mashup`
    Then the exit status should be 0
    And the output should contain:
    """
    Usage: sphere-ipinfo-mashup
    """