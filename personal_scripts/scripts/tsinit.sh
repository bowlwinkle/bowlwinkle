#!/bin/bash

# Simple script to bootstrap a small typescript environment
function createProject() {
    # Define required commands
    depArr=("jq" "yarn" "npx" "node")

    # Check if required commands are installed
    for OUTPUT in ${depArr[@]}
    do
        if ! command -v $OUTPUT 2>&1 >/dev/null
        then
            echo "${OUTPUT} command is required to use this script...exiting."
            exit 1
        fi
    done

    mkdir src && touch src/index.ts && echo "console.log('Hello, world!');" > src/index.ts
    mkdir test && mkdir ./test/unit && touch test/unit/index.test.ts && echo "Write tests"
    touch jest.config.ts

    echo "import type {Config} from '@jest/types';

// Sync object
const config: Config.InitialOptions = {
verbose: true,
transform: {
'^.+\\.tsx?$': 'ts-jest',
},
};

    export default config;" >> jest.config.ts

    echo "describe('pass', () => {
  it('passes', () => {
    expect(true).toEqual(true)
  })
})" >> ./test/unit/index.test.ts

    yarn init -y
    yarn add typescript @types/node concurrently nodemon -D
    yarn add -D jest @types/jest ts-jest ts-node
    npx tsc --init

    # # Setup ESLint and prettier - blog here https://blog.logrocket.com/linting-typescript-eslint-prettier/
    # yarn add eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin -D
    # npx eslint --init

    # yarn add prettier eslint-config-prettier eslint-plugin-prettier -D

    # Update package.json
    jq '.type = "module"' package.json > tmp.json && mv tmp.json package.json
    jq '.scripts.build = "tsc"' package.json > tmp.json && mv tmp.json package.json
    jq '.scripts.start = "tsc && concurrently \"tsc -w\" \"nodemon --quiet dist/index.js\""' package.json > tmp.json && mv tmp.json package.json
    jq '.scripts.test = "jest"' package.json > tmp.json && mv tmp.json package.json

    # Strip out comments from tsconfig.json
    npx --yes strip-json-comments-cli tsconfig.json | jq . -r > tmp.json && mv tmp.json tsconfig.json

    # Update tsconfig.json
    jq '.compilerOptions.module = "ESNext"' tsconfig.json > tmp.json && mv tmp.json tsconfig.json
    jq '.compilerOptions.outDir = "dist"' tsconfig.json > tmp.json && mv tmp.json tsconfig.json
    jq '.compilerOptions.moduleResolution = "node"' tsconfig.json > tmp.json && mv tmp.json tsconfig.json
    jq '.include = ["src/**/*.ts"]' tsconfig.json > tmp.json && mv tmp.json tsconfig.json
    jq '.exclude = [ "src/**/*.test.ts", "test/**/*.test.ts" ]' tsconfig.json > tmp.json && mv tmp.json tsconfig.json

    jq . package.json
}

# State project is created in current directory and if script should proceed.
read -p "Do you wish to setup Typescript project here $(pwd) (y/n)?" choice
case "$choice" in
  y|Y ) createProject;;
  n|N ) exit;;
  * ) echo "invalid option...exiting"; exit;;
esac


