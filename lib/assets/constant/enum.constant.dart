enum CollectState { STRANGE, CONCERNED, SElF }

const CollectStateValues = ["未关注", "已关注", "自己"];

enum FollowState { STRANGE, CONCERNED, SElF }

const FollowStateValues = ["未关注", "已关注", "自己"];

enum VerificationCodeOperation { REGISTER, FORGET }

const VerificationCodeOperationValues = ["注册账号", "忘记密码"];

enum Gender {
  MALE,
  FEMALE,
  UNKNOWN,
  INCONVENIENT,
}

const GenderValues = ["男孩", "女孩", "未知", "不便透露"];

enum PrivacyState { PUBLIC, PRIVATE }

const PrivacyStateValues = ["公开", "隐藏"];

enum BlockState { NORMAL, SHIELD }

const BlockStateValues = ["正常", "屏蔽"];
