/*
 *  Copyright 2017 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#import "WebRTC/RTCVideoCodecFactory.h"

#import "WebRTC/RTCVideoCodecH264.h"
#if defined(USE_BUILTIN_SW_CODECS)
#import "WebRTC/RTCVideoDecoderVP8.h"
#if !defined(RTC_DISABLE_VP9)
#import "WebRTC/RTCVideoDecoderVP9.h"
#endif
#endif

@implementation RTCDefaultVideoDecoderFactory

- (id<RTCVideoDecoder>)createDecoder:(RTCVideoCodecInfo *)info {
  if ([info.name isEqualToString:kRTCVideoCodecH264Name]) {
    return [[RTCVideoDecoderH264 alloc] init];
#if defined(USE_BUILTIN_SW_CODECS)
  } else if ([info.name isEqualToString:kRTCVideoCodecVp8Name]) {
    return [RTCVideoDecoderVP8 vp8Decoder];
#if !defined(RTC_DISABLE_VP9)
  } else if ([info.name isEqualToString:kRTCVideoCodecVp9Name]) {
    return [RTCVideoDecoderVP9 vp9Decoder];
#endif
#endif
  }

  return nil;
}

- (NSArray<RTCVideoCodecInfo *> *)supportedCodecs {
  return @[
    [[RTCVideoCodecInfo alloc] initWithName:kRTCVideoCodecH264Name],
#if defined(USE_BUILTIN_SW_CODECS)
    [[RTCVideoCodecInfo alloc] initWithName:kRTCVideoCodecVp8Name],
#if !defined(RTC_DISABLE_VP9)
    [[RTCVideoCodecInfo alloc] initWithName:kRTCVideoCodecVp9Name],
#endif
#endif
  ];
}

@end
