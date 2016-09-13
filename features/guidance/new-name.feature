@routing  @guidance
Feature: New-Name Instructions

    Background:
        Given the profile "car"
        Given a grid size of 100 meters

    Scenario: Undisturbed name Change
        Given the node map
            | a |   | b |   | c |

        And the ways
            | nodes  |
            | ab     |
            | bc     |

       When I route I should get
            | waypoints | route    | turns                           |
            | a,c       | ab,bc,bc | depart,new name straight,arrive |


    Scenario: Undisturbed Name Change with unannounced Turn Right
        Given the node map
            | a |   | b |   |   |
            |   |   |   |   | c |

        And the ways
            | nodes  |
            | ab     |
            | bc     |

       When I route I should get
            | waypoints | route    | turns                               |
            | a,c       | ab,bc,bc | depart,new name slight right,arrive |

    Scenario: Undisturbed Name Change with unannounced Turn Left
        Given the node map
            |   |   |   |   | c |
            | a |   | b |   |   |

        And the ways
            | nodes  |
            | ab     |
            | bc     |

       When I route I should get
            | waypoints | route    | turns                              |
            | a,c       | ab,bc,bc | depart,new name slight left,arrive |

    Scenario: Disturbed Name Change with Turn
        Given the node map
            | a |   | b |   |   |
            |   | d |   |   | c |

        And the ways
            | nodes  |
            | ab     |
            | bc     |
            | db     |

       When I route I should get
            | waypoints | route    | turns                               |
            | a,c       | ab,bc,bc | depart,new name slight right,arrive |

    Scenario: Undisturbed Name Change with announced Turn Left
        Given the node map
            |   |   | c |
            | a |   | b |

        And the ways
            | nodes  |
            | ab     |
            | bc     |

       When I route I should get
            | waypoints | route    | turns                       |
            | a,c       | ab,bc,bc | depart,new name left,arrive |

    Scenario: Undisturbed Name Change with announced Turn Sharp Left
        Given the node map
            | c |   |   |
            | a |   | b |

        And the ways
            | nodes  |
            | ab     |
            | bc     |

       When I route I should get
            | waypoints | route    | turns                             |
            | a,c       | ab,bc,bc | depart,new name sharp left,arrive |

    Scenario: Undisturbed Name Change with announced Turn Right
        Given the node map
            | a |   | b |
            |   |   | c |

        And the ways
            | nodes  |
            | ab     |
            | bc     |

       When I route I should get
            | waypoints | route    | turns                        |
            | a,c       | ab,bc,bc | depart,new name right,arrive |

    Scenario: Undisturbed Name Change with announced Turn Sharp Right
        Given the node map
            | a |   | b |
            | c |   |   |

        And the ways
            | nodes  |
            | ab     |
            | bc     |

       When I route I should get
            | waypoints | route    | turns                              |
            | a,c       | ab,bc,bc | depart,new name sharp right,arrive |


    Scenario: Disturbed Name Change with minor road class
        Given the node map
            | a |   | b |   | d |
            |   |   |   |   | c |

        And the ways
            | nodes  | highway     | oneway |
            | ab     | residential | yes    |
            | bc     | residential | yes    |
            | bd     | service     | yes    |

       When I route I should get
            | waypoints | route    | turns                               |
            | a,c       | ab,bc,bc | depart,new name slight right,arrive |

    Scenario: Empty road names - Announce Change From, suppress Change To
        Given the node map
            | a |  | b | 1 | c |  | d |

        And the ways
            | nodes | name |
            | ab    | ab   |
            | bc    |      |
            | cd    | cd   |

        When I route I should get
            | waypoints | route    | turns                           |
            | a,d       | ab,cd,cd | depart,new name straight,arrive |
            | a,1       | ab,      | depart,arrive                   |

    Scenario: Empty road names - Loose name shortly
        Given the node map
            | a |  | b |  | c |  | d |  | e |

        And the ways
            | nodes | name      |
            | ab    | name      |
            | bc    | with-name |
            | cd    |           |
            | de    | with-name |

        When I route I should get
            | waypoints | route                    | turns                           |
            | a,e       | name,with-name,with-name | depart,new name straight,arrive |
            | b,e       | with-name,with-name      | depart,arrive                   |

    Scenario: Both Name and Ref Empty
        Given the node map
            | a |  | b |  | c |

        And the ways
            | nodes | name | ref |
            | ab    |      |     |
            | bc    |      |     |

        When I route I should get
            | waypoints | route | turns         |
            | a,c       | ,     | depart,arrive |

    Scenario: Same Name, Ref Extended
        Given the node map
            | a |  | b |  | c |

        And the ways
            | nodes | name | ref   |
            | ab    | A    | B1    |
            | bc    | C    | B1;B2 |

        When I route I should get
            | waypoints | route | turns                           |
            | a,c       | A,C,C | depart,new name straight,arrive |

    Scenario: Same Name, Ref Removed
        Given the node map
            | a |  | b |  | c |

        And the ways
            | nodes | name | ref   |
            | ab    | A    | B1;B2 |
            | bc    | C    | B1    |

        When I route I should get
            | waypoints | route | turns                           |
            | a,c       | A,C,C | depart,new name straight,arrive |

    Scenario: Name Removed, Ref Extended
        Given the node map
            | a |  | b |  | c |

        And the ways
            | nodes | name | ref   |
            | ab    | A    | B1    |
            | bc    |      | B1;B2 |

        When I route I should get
            | waypoints | route | turns         |
            | a,c       | A,    | depart,arrive |

    Scenario: Name Added, Ref Removed
        Given the node map
            | a |  | b |  | c |

        And the ways
            | nodes | name | ref   |
            | ab    |      | B1    |
            | bc    | A    |       |

        When I route I should get
            | waypoints | route | turns         |
            | a,c       | ,A    | depart,arrive |
