#!/usr/bin/env bash
######################################################
# Validate dependency versions.
# Globals:
#
# Params
######################################################
echo starting script - validate_dependencies.sh

# Stop on errors
set -e

# Check OS Version
os_version=$(grep PRETTY_NAME /etc/os-release | cut -d'=' -f2 | tr -d '"')
if [ "$os_version" == "Debian GNU/Linux 11 (bullseye)" ]; then
    echo "Valide OS version ${os_version}"
else
    echo "OS version does not match Debian GNU/Linux 11 (bullseye). Current version is $os_version"
fi

# Check Ruby Version
ruby_version=$(ruby -v)
version_number=$(echo "$ruby_version" | awk '{print $2}' | cut -d'p' -f1)
if [ "$version_number" == "2.7.4" ]; then
    echo "Valid Ruby version matches 2.7.4 ${ruby_version}"
else
    echo "Ruby version does not match 2.7.4. Current version is $ruby_version"
fi

gem_version=$(gem -v)
if [ "$gem_version" == "3.1.6" ]; then
    echo "Gem version matches 3.1.6"
else
    echo "Gem version does not match 3.1.6. Current version is $gem_version"
fi

# gcc -v
# # gcc version 10.2.1 20210110 (Debian 10.2.1-6)
# g++ -v
# # gcc version 10.2.1 20210110 (Debian 10.2.1-6)

make_version=$(make -v)
if [ "$make_version" == "GNU Make 4.3" ]; then
    echo "Make version matches 4.3"
else
    echo "Make version does not match 4.3. Current version is $make_version"
fi

# Check Node Version
node_version=$(node -v)
if [ "$node_version" == "v14.21.3" ]; then
    echo "Node version matches 14.21.3"
else
    echo "Node version does not match 14.21.3. Current version is $node_version"
fi

# Check NPM Version
npm_version=$(npm -v)
if [ "$npm_version" == "6.14.18" ]; then
    echo "NPM version matches 6.14.18"
else
    echo "NPM version does not match 6.14.18. Current version is $npm_version"
fi

# Check Gulp Version
gulp_version=$(gulp -v)
if [ "$gulp_version" == "CLI version: 2.3.0" ]; then
    echo "Gulp version matches 2.3.0"
else
    echo "Gulp version does not match 2.3.0. Current version is $gulp_version"
fi

# Check Bundler Version
bundler_version=$(bundler -v)
if [ "$bundler_version" == "Bundler version 2.1.4" ]; then
    echo "Bundler version matches 2.1.4"
else
    echo "Bundler version does not match 2.1.4. Current version is $bundler_version"
fi

# Check Jekyll Version
jekyll_version=$(jekyll -v)
if [ "$jekyll_version" == "jekyll 3.9.0" ]; then
    echo "Jekyll version matches 3.9.0"
else
    echo "Jekyll version does not match 3.9.0. Current version is $jekyll_version"
fi



# jekyll --version
# # jekyll 3.9.0
# bundler --version
# # Bundler version 2.1.4
# npm --version
# # 6.14.18
# node --version
# # v14.21.3
# gulp --version
# # CLI version: 2.3.0
