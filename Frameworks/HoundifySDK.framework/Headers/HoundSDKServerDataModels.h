//
//  HoundSDKServerDataModels.h
//  SHHound
//
//  Created by Cyril MacDonald on 2015-06-05.
//  Copyright (c) 2015 SoundHound. All rights reserved.
//

#import "HoundDataModels.h"

#pragma mark - Forward declarations

@class HoundDataBuildInfo;
@class HoundDataCommandError;
@class HoundDataCommandResult;
@class HoundDataCommandResultArray;
@class HoundDataDynamicResponse;
@class HoundDataHints;
@class HoundDataHintsSpoken;
@class HoundDataHintsWritten;
@class HoundDataHintsWrittenHints;
@class HoundDataHintsWrittenHintsArray;
@class HoundDataHoundServer;
@class HoundDataHoundServerDisambiguation;
@class HoundDataHoundServerDisambiguationChoiceData;
@class HoundDataHoundServerDisambiguationChoiceDataArray;
@class HoundDataHoundServerDomainUsage;
@class HoundDataHoundServerDomainUsageArray;
@class HoundDataHTMLData;
@class HoundDataHTMLDataHTMLHead;
@class HoundDataInformationNugget;
@class HoundDataInformationNuggetArray;
@class HoundDataPreview;
@class HoundDataTemplate;

#pragma mark - HoundDataCommandResultViewType

typedef NS_ENUM(NSUInteger, HoundDataCommandResultViewType) {
	HoundDataCommandResultViewTypeNone,
	HoundDataCommandResultViewTypeNative,
	HoundDataCommandResultViewTypeTemplate,
	HoundDataCommandResultViewTypeHTML,
	HoundDataCommandResultViewTypeError,
};

#pragma mark - HoundDataDynamicResponseViewType

typedef NS_ENUM(NSUInteger, HoundDataDynamicResponseViewType) {
	HoundDataDynamicResponseViewTypeNone,
	HoundDataDynamicResponseViewTypeNative,
	HoundDataDynamicResponseViewTypeTemplate,
	HoundDataDynamicResponseViewTypeHTML,
	HoundDataDynamicResponseViewTypeError,
};

#pragma mark - HoundDataEmotion

/**
	The specification of an emotion for a client to display
*/
typedef NS_ENUM(NSUInteger, HoundDataEmotion) {
	HoundDataEmotionNone,
	HoundDataEmotionNeutral,
	HoundDataEmotionHappy,
	HoundDataEmotionSad,
	HoundDataEmotionAngry,
};

#pragma mark - HoundDataHintsSpokenPriority

typedef NS_ENUM(NSUInteger, HoundDataHintsSpokenPriority) {
	HoundDataHintsSpokenPriorityNone,
	HoundDataHintsSpokenPriorityLow,
	HoundDataHintsSpokenPriorityMedium,
	HoundDataHintsSpokenPriorityHigh,
};

#pragma mark - HoundDataHintsWrittenHintsPriority

typedef NS_ENUM(NSUInteger, HoundDataHintsWrittenHintsPriority) {
	HoundDataHintsWrittenHintsPriorityNone,
	HoundDataHintsWrittenHintsPriorityLow,
	HoundDataHintsWrittenHintsPriorityMedium,
	HoundDataHintsWrittenHintsPriorityHigh,
};

#pragma mark - HoundDataHoundServerFormat

typedef NS_ENUM(NSUInteger, HoundDataHoundServerFormat) {
	HoundDataHoundServerFormatNone,
	HoundDataHoundServerFormatSoundHoundVoiceSearchResult,
	HoundDataHoundServerFormatHoundQueryResult,
};

#pragma mark - HoundDataHoundServerFormatVersion

typedef NS_ENUM(NSUInteger, HoundDataHoundServerFormatVersion) {
	HoundDataHoundServerFormatVersionNone,
	HoundDataHoundServerFormatVersion10,
};

#pragma mark - HoundDataHoundServerStatus

typedef NS_ENUM(NSUInteger, HoundDataHoundServerStatus) {
	HoundDataHoundServerStatusNone,
	HoundDataHoundServerStatusOK,
	HoundDataHoundServerStatusError,
};

#pragma mark - HoundDataHoundServerLocalOrRemote

typedef NS_ENUM(NSUInteger, HoundDataHoundServerLocalOrRemote) {
	HoundDataHoundServerLocalOrRemoteNone,
	HoundDataHoundServerLocalOrRemoteLocal,
	HoundDataHoundServerLocalOrRemoteRemote,
};

#pragma mark - HoundDataIcon

/**
	The specification of an icon for a client to display
*/
typedef NS_ENUM(NSUInteger, HoundDataIcon) {
	HoundDataIconNone,
	HoundDataIconNeutral,
	HoundDataIconHappy,
	HoundDataIconSad,
	HoundDataIconAngry,
	HoundDataIconCoffee,
};

#pragma mark - HoundDataBuildInfo

/**
	Information about the server that produced a result
*/
@interface HoundDataBuildInfo : HoundData

@property(nonatomic, copy, nullable) NSString* user;
@property(nonatomic, copy, nullable) NSDate* date;
@property(nonatomic, copy, nullable) NSString* machine;
@property(nonatomic, copy, nullable) NSString* SVNRevision;
@property(nonatomic, copy, nullable) NSString* SVNBranch;
@property(nonatomic, copy, nullable) NSString* buildNumber;
@property(nonatomic, copy, nullable) NSString* kind;
@property(nonatomic, copy, nullable) NSString* variant;

@end

#pragma mark - HoundDataCommandError

/**
	An error in processing a request
*/
@interface HoundDataCommandError : HoundData

@property(nonatomic, copy, nullable) NSString* errorMessage;
@property(nonatomic, copy, nullable) NSString* expectedCommandKind;
@property(nonatomic, copy, nullable) NSString* errorType;

@end

#pragma mark - HoundDataCommandResult

/**
	The results from the server to a particular parse of a request
*/
@interface HoundDataCommandResult : HoundData

@property(nonatomic, copy, nullable) NSString* spokenResponse;
@property(nonatomic, copy, nullable) NSString* spokenResponseLong;
@property(nonatomic, copy, nullable) NSString* writtenResponse;
@property(nonatomic, copy, nullable) NSString* writtenResponseLong;
@property(nonatomic, copy, nullable) NSString* spokenResponseSSML;
@property(nonatomic, copy, nullable) NSString* spokenResponseSSMLLong;
@property(nonatomic, assign) BOOL autoListen;
@property(nonatomic, copy, nullable) NSString* userVisibleMode;
@property(nonatomic, assign) BOOL isRepeat;
@property(nonatomic, strong, nullable) HoundDataInformationNuggetArray* additionalInformation;
@property(nonatomic, strong, nullable) NSDictionary* conversationState;
@property(nonatomic, strong, nullable) HoundDataNumberArray* viewType;
@property(nonatomic, copy, nullable) NSString* templateName;
@property(nonatomic, strong, nullable) HoundDataTemplate* templateData;
@property(nonatomic, strong, nullable) HoundDataTemplate* combiningTemplateData;
@property(nonatomic, strong, nullable) HoundDataPreview* preview;
@property(nonatomic, strong, nullable) HoundDataHTMLData* HTMLData;
@property(nonatomic, strong, nullable) HoundDataHints* hints;
@property(nonatomic, assign) HoundDataEmotion emotion;
@property(nonatomic, assign) HoundDataIcon icon;
@property(nonatomic, copy, nullable) NSString* responseAudioBytes;
@property(nonatomic, copy, nullable) NSString* responseAudioEncoding;
@property(nonatomic, copy, nullable) NSString* responseAudioError;
@property(nonatomic, strong, nullable) HoundDataStringArray* requiredFeatures;
@property(nonatomic, strong, nullable) HoundDataDynamicResponse* clientActionSucceededResult;
@property(nonatomic, strong, nullable) HoundDataDynamicResponse* clientActionFailedResult;
@property(nonatomic, strong, nullable) HoundDataDynamicResponse* requiredFeaturesSupportedResult;
@property(nonatomic, strong, nullable) id sendBack;
@property(nonatomic, copy, nullable) NSString* errorType;
@property(nonatomic, strong, nullable) HoundDataCommandError* errorData;
@property(nonatomic, copy, nullable) NSString* commandKind;
@property(nonatomic, strong, nullable) NSDictionary* userInfo;

@end

#pragma mark - HoundDataDynamicResponse

/**
	Action result-specific results from the server
*/
@interface HoundDataDynamicResponse : HoundData

@property(nonatomic, copy, nullable) NSString* spokenResponse;
@property(nonatomic, copy, nullable) NSString* spokenResponseLong;
@property(nonatomic, copy, nullable) NSString* writtenResponse;
@property(nonatomic, copy, nullable) NSString* writtenResponseLong;
@property(nonatomic, assign) BOOL autoListen;
@property(nonatomic, copy, nullable) NSString* userVisibleMode;
@property(nonatomic, strong, nullable) NSDictionary* conversationState;
@property(nonatomic, assign) NSUInteger conversationStateTime;
@property(nonatomic, strong, nullable) HoundDataNumberArray* viewType;
@property(nonatomic, copy, nullable) NSString* templateName;
@property(nonatomic, strong, nullable) HoundDataTemplate* templateData;
@property(nonatomic, copy, nullable) NSString* smallScreenHTML;
@property(nonatomic, copy, nullable) NSString* largeScreenHTML;
@property(nonatomic, strong, nullable) HoundDataHints* hints;
@property(nonatomic, assign) HoundDataEmotion emotion;
@property(nonatomic, assign) HoundDataIcon icon;

@end

#pragma mark - HoundDataHints

/**
	Hints to the user
*/
@interface HoundDataHints : HoundData

@property(nonatomic, strong, nullable) HoundDataHintsSpoken* spoken;
@property(nonatomic, strong, nullable) HoundDataHintsWritten* written;

@end

#pragma mark - HoundDataHintsSpoken

@interface HoundDataHintsSpoken : HoundData

@property(nonatomic, copy, nullable) NSString* text;
@property(nonatomic, assign) HoundDataHintsSpokenPriority priority;

@end

#pragma mark - HoundDataHintsWritten

@interface HoundDataHintsWritten : HoundData

@property(nonatomic, strong, nullable) HoundDataHintsWrittenHintsArray* hints;

@end

#pragma mark - HoundDataHintsWrittenHints

@interface HoundDataHintsWrittenHints : HoundData

@property(nonatomic, copy, nullable) NSString* text;
@property(nonatomic, assign) HoundDataHintsWrittenHintsPriority priority;

@end

#pragma mark - HoundDataHoundServer

/**
	The JSON returned by the SoundHound Hound servers
*/
@interface HoundDataHoundServer : HoundData

@property(nonatomic, assign) HoundDataHoundServerFormat format;
@property(nonatomic, assign) HoundDataHoundServerFormatVersion formatVersion;
@property(nonatomic, assign) HoundDataHoundServerStatus status;
@property(nonatomic, copy, nullable) NSString* errorMessage;
@property(nonatomic, assign) NSUInteger numToReturn;
@property(nonatomic, strong, nullable) HoundDataCommandResultArray* allResults;
@property(nonatomic, strong, nullable) HoundDataHoundServerDisambiguation* disambiguation;
@property(nonatomic, strong, nullable) HoundDataNumberArray* resultsAreFinal;
@property(nonatomic, strong, nullable) HoundDataHoundServerDomainUsageArray* domainUsage;
@property(nonatomic, strong, nullable) HoundDataBuildInfo* buildInfo;
@property(nonatomic, copy, nullable) NSString* serverGeneratedId;
@property(nonatomic, assign) double audioLength;
@property(nonatomic, assign) double realSpeechTime;
@property(nonatomic, assign) double cpuSpeechTime;
@property(nonatomic, assign) double realTime;
@property(nonatomic, assign) double cpuTime;
@property(nonatomic, assign) HoundDataHoundServerLocalOrRemote localOrRemote;
@property(nonatomic, copy, nullable) NSString* localOrRemoteReason;

@end

#pragma mark - HoundDataHoundServerDisambiguation

@interface HoundDataHoundServerDisambiguation : HoundData

@property(nonatomic, assign) NSUInteger numToShow;
@property(nonatomic, strong, nullable) HoundDataHoundServerDisambiguationChoiceDataArray* choiceData;

@end

#pragma mark - HoundDataHoundServerDisambiguationChoiceData

@interface HoundDataHoundServerDisambiguationChoiceData : HoundData

@property(nonatomic, copy, nullable) NSString* transcription;
@property(nonatomic, assign) double confidenceScore;
@property(nonatomic, copy, nullable) NSString* fixedTranscription;

@end

#pragma mark - HoundDataHoundServerDomainUsage

@interface HoundDataHoundServerDomainUsage : HoundData

@property(nonatomic, copy, nullable) NSString* domain;
@property(nonatomic, copy, nullable) NSString* domainUniqueID;
@property(nonatomic, assign) double creditsUsed;

@end

#pragma mark - HoundDataHTMLData

/**
	HTML to be displayed by the client
*/
@interface HoundDataHTMLData : HoundData

@property(nonatomic, strong, nullable) HoundDataHTMLDataHTMLHead* HTMLHead;
@property(nonatomic, copy, nullable) NSString* smallScreenHTML;
@property(nonatomic, copy, nullable) NSString* largeScreenHTML;
@property(nonatomic, copy, nullable) NSURL* smallScreenURL;
@property(nonatomic, copy, nullable) NSURL* largeScreenURL;

@end

#pragma mark - HoundDataHTMLDataHTMLHead

@interface HoundDataHTMLDataHTMLHead : HoundData

@property(nonatomic, copy, nullable) NSString* CSS;
@property(nonatomic, copy, nullable) NSString* JS;

@end

#pragma mark - HoundDataInformationNugget

/**
	A chunk of information in response to a user query
*/
@interface HoundDataInformationNugget : HoundData

@property(nonatomic, copy, nullable) NSString* spokenResponse;
@property(nonatomic, copy, nullable) NSString* spokenResponseLong;
@property(nonatomic, copy, nullable) NSString* writtenResponse;
@property(nonatomic, copy, nullable) NSString* writtenResponseLong;
@property(nonatomic, copy, nullable) NSString* spokenResponseSSML;
@property(nonatomic, copy, nullable) NSString* spokenResponseSSMLLong;
@property(nonatomic, strong, nullable) HoundDataTemplate* templateData;
@property(nonatomic, strong, nullable) HoundDataTemplate* combiningTemplateData;
@property(nonatomic, strong, nullable) HoundDataPreview* preview;
@property(nonatomic, copy, nullable) NSString* smallScreenHTML;
@property(nonatomic, copy, nullable) NSString* largeScreenHTML;
@property(nonatomic, strong, nullable) HoundDataHints* hints;
@property(nonatomic, assign) HoundDataEmotion emotion;
@property(nonatomic, assign) HoundDataIcon icon;
@property(nonatomic, copy, nullable) NSString* nuggetKind;

@end

#pragma mark - HoundDataPreview

/**
	The data to specify how to display query results as a preview
*/
@interface HoundDataPreview : HoundData


@end

#pragma mark - HoundDataTemplate

/**
	The data to specify how to display results using one of a pre-defined number of display format templates
*/
@interface HoundDataTemplate : HoundData

@property(nonatomic, copy, nullable) NSString* templateName;

@end

#pragma mark - HoundDataCommandResultArray

@interface HoundDataCommandResultArray : HoundDataArray


@end

#pragma mark - HoundDataHintsWrittenHintsArray

@interface HoundDataHintsWrittenHintsArray : HoundDataArray


@end

#pragma mark - HoundDataHoundServerDisambiguationChoiceDataArray

@interface HoundDataHoundServerDisambiguationChoiceDataArray : HoundDataArray


@end

#pragma mark - HoundDataHoundServerDomainUsageArray

@interface HoundDataHoundServerDomainUsageArray : HoundDataArray


@end

#pragma mark - HoundDataInformationNuggetArray

@interface HoundDataInformationNuggetArray : HoundDataArray


@end

