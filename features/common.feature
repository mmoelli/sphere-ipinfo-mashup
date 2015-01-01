Feature: Show common information for tooling

  Scenario: Show general help
    When I run `node ../../bin/sphere-ipinfo-mashup`
    Then the exit status should be 1
    And the output should contain:
    """
    Usage: node ../../bin/sphere-ipinfo-mashup
    """