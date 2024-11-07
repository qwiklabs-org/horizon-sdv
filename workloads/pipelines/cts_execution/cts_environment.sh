#!/usr/bin/env bash

# Copyright (c) 2024 Accenture, All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Description:
# Install Android CTS for use when testing Cuttlefish Virtual Device (CVD).
#
# References:
# https://source.android.com/docs/devices/cuttlefish/cts

CTS_DOWNLOAD_URL=${CTS_DOWNLOAD_URL:-}
CTS_PATHNAME=${CTS_PATHNAME:-android-cts}
CTS_TESTPLAN=${CTS_TESTPLAN:-cts-virtual-device-stable}
# Default to a simple module with a single test.
CTS_MODULE=${CTS_MODULE:-CtsHostsideNumberBlockingTestCases}
# android.app.RemoteActionTest#testClone}
CTS_TEST=${CTS_TEST:-}
CTS_TIMEOUT=${CTS_TIMEOUT:-60}

# Architecture x86_64 is only supported at this time.
ARCHITECTURE=${ARCHITECTURE:-x86_64}

# Shards should match CVD --num_instances (NUM_INSTANCES).
SHARD_COUNT=${SHARD_COUNT:-8}

# Don't risk downloading CTS locally!
if [ "$(uname -s)" = "Darwin" ]; then
    echo "This script is only supported on Linux"
    exit 1
fi

# Show variables.
VARIABLES="
Environment:
    CTS_DOWNLOAD_URL=${CTS_DOWNLOAD_URL}
    CTS_PATHNAME=${CTS_PATHNAME}

    ARCHITECTURE=${ARCHITECTURE}

    CTS variables:
    CTS_TESTPLAN=${CTS_TESTPLAN}
    CTS_MODULE=${CTS_MODULE}
    CTS_TEST=${CTS_TEST}
    CTS_TIMEOUT=${CTS_TIMEOUT}
    SHARD_COUNT=${SHARD_COUNT} (--shard-count ${SHARD_COUNT})

    Storage Usage (/dev/sda1): $(df -h /dev/sda1 | tail -1 | awk '{print "Used " $3 " of " $2}')
   "
echo "${VARIABLES}"
