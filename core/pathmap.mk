#
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# A central place to define mappings to paths, to avoid hard-coding
# them in Android.mk files. Not meant for header file include directories,
# despite the fact that it was historically used for that!
#
# If you want this for a library's header files, use LOCAL_EXPORT_C_INCLUDES
# instead. Then users of the library don't have to do anything --- they'll
# have the correct header files added to their include path automatically.
#

#
# TODO: Allow each project to define stuff like this before the per-module
#       Android.mk files are included, so we don't need to have a big central
#       list.
#

#
# A mapping from shorthand names to include directories.
#
pathmap_INCL := \
    camera:system/media/camera/include \
    frameworks-base:frameworks/base/include \
    frameworks-native:frameworks/native/include \
    libhardware:hardware/libhardware/include \
    libhardware_legacy:hardware/libhardware_legacy/include \
    libril:hardware/ril/include \
    opengl-tests-includes:frameworks/native/opengl/tests/include \
    recovery:bootable/recovery \
    system-core:system/core/include \
    audio:system/media/audio/include \
    audio-effects:system/media/audio_effects/include \
    audio-utils:system/media/audio_utils/include \
    audio-route:system/media/audio_route/include \
    wilhelm:frameworks/wilhelm/include \
    wilhelm-ut:frameworks/wilhelm/src/ut \
    mediandk:frameworks/av/media/ndk/ \
    speex:external/speex/include

#
# Returns the path to the requested module's include directory,
# relative to the root of the source tree.  Does not handle external
# modules.
#
# $(1): a list of modules (or other named entities) to find the includes for
#
define include-path-for
$(foreach n,$(1),$(patsubst $(n):%,%,$(filter $(n):%,$(pathmap_INCL))))
endef

#
# Many modules expect to be able to say "#include <jni.h>",
# so make it easy for them to find the correct path.
#
JNI_H_INCLUDE := libnativehelper/include/nativehelper

#
# A list of all source roots under frameworks/base, which will be
# built into the android.jar.
#
FRAMEWORKS_BASE_SUBDIRS := \
	$(addsuffix /java, \
            services/net \
	    core \
	    graphics \
	    location \
	    media \
	    media/mca/effect \
	    media/mca/filterfw \
	    media/mca/filterpacks \
	    drm \
	    opengl \
	    sax \
	    telecomm \
	    telephony \
	    wifi \
	    keystore \
	    rs \
	    ../../device/softwinner/common/addons/framework/gpio \
	    ../../device/softwinner/common/addons/framework/systemmix \
	    ../../device/softwinner/common/addons/framework/admanager \
	    ../../device/softwinner/common/addons/framework/nfsmanager \
	    ../../device/softwinner/common/addons/framework/os \
	    ../../device/softwinner/common/addons/framework/securefile \
	    ../../device/softwinner/common/addons/framework/utils \
            ../../device/softwinner/common/addons/framework/audio \
            ../../device/softwinner/common/addons/framework/display \
            ../../vendor/operator/cmcc/frameworks/network \
	 )

#
# A version of FRAMEWORKS_BASE_SUBDIRS that is expanded to full paths from
# the root of the tree.  This currently needs to be here so that other libraries
# and apps can find the .aidl files in the framework, though we should really
# figure out a better way to do this.
#
FRAMEWORKS_BASE_JAVA_SRC_DIRS := \
	$(addprefix frameworks/base/,$(FRAMEWORKS_BASE_SUBDIRS))

#
# A list of all source roots under frameworks/support.
#
FRAMEWORKS_SUPPORT_SUBDIRS := \
        annotations \
        v4 \
        v7/gridlayout \
        v7/cardview \
        v7/mediarouter \
        v7/palette \
        v8/renderscript \
        v13 \
        v17/leanback \
        design \
        percent \
        recommendation \
        v7/preference \
        v14/preference \
        v17/preference-leanback \
        documents-archive \
        customtabs

#
# A list of all source roots under frameworks/multidex.
#
FRAMEWORKS_MULTIDEX_SUBDIRS := \
        multidex/library/src \
        multidex/instrumentation/src

#
# A version of FRAMEWORKS_SUPPORT_SUBDIRS that is expanded to full paths from
# the root of the tree.
#
FRAMEWORKS_SUPPORT_JAVA_SRC_DIRS := \
	$(addprefix frameworks/support/,$(FRAMEWORKS_SUPPORT_SUBDIRS)) \
	$(addprefix frameworks/,$(FRAMEWORKS_MULTIDEX_SUBDIRS)) \
        frameworks/support/graphics/drawable/animated \
        frameworks/support/graphics/drawable/static \
	frameworks/support/v7/appcompat/src \
	frameworks/support/v7/recyclerview/src

#
# A list of support library modules.
#
FRAMEWORKS_SUPPORT_JAVA_LIBRARIES := \
    $(foreach dir,$(FRAMEWORKS_SUPPORT_SUBDIRS),android-support-$(subst /,-,$(dir))) \
    android-support-vectordrawable \
    android-support-animatedvectordrawable \
    android-support-v7-appcompat \
    android-support-v7-recyclerview \
    android-support-multidex \
    android-support-multidex-instrumentation

#
# A list of all documented source roots under frameworks/data-binding.
#
FRAMEWORKS_DATA_BINDING_SUBDIRS := \
        baseLibrary/src/main \
        extensions/library/src/main \
        extensions/library/src/doc

#
# A version of FRAMEWORKS_DATA_BINDING_SUBDIRS that is expanded to full paths from
# the root of the tree.
#
FRAMEWORKS_DATA_BINDING_JAVA_SRC_DIRS := \
	$(addprefix frameworks/data-binding/,$(FRAMEWORKS_DATA_BINDING_SUBDIRS))

