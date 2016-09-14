@contract @options @verify-weights
Feature: osrm-contract command line option: verify-weights

    Background: Log edge weight updates over given factor

    Scenario: Logging only weights with updates over factor of 2
        Given the node locations
            | node | lat        | lon      |
            | a    | 0.1        | 0.1      |
            | b    | .05        | 0.1      |
            | c    | 0.0        | 0.1      |
        And the ways
            | nodes | highway     |
            | ab    | residential |
            | bc    | primary     |
        Given the profile "testbot"
        Given the extract extra arguments "--generate-edge-lookup"
        Given the speed file
        """
        1,2,125
        """
        And the data has been extracted
        When I run "osrm-contract --verify-weights 2 --segment-speed-file speeds.csv {extracted_base}.osrm"
        Then stderr should contain "verify weights"
        Then stderr should contain "Assigned new speed of 125"
        And I route I should get
            | from | to | route          | speed   |
            | a    | b  | ab,ab          | 24 km/h |
            | a    | c  | ab,bc,bc       | 29 km/h |
            | b    | c  | bc,bc          | 36 km/h |
