# Stagings

There is a file `env_config.dart` inside which there is `Stagings` class.
Different `stagings` allows us to combine different variations of builds and data.
So far we have 3 different stagings:

1. `dev`
1. `internal`
1. `prod`

### So what's the difference?

There are a few main aspects where those are different:
- build type
- data (content)
- analytics and configs environment (firebase project)
- usage

#### 
| staging       | build type    | data (content)    | firebase project  | usage                                                     |
| --            | --            | --                | --                | --                                                        |
| `dev`         | `debug`       | `dev storage`     | `dev`             | during development cycle                                  |
| `internal`    | `release`     | `dev storage`     | `dev`             | internal testing, after every merge to the `dev` branch   |
| `prod`        | `release`     | `prod storage`    | `prod`            | production                                                |