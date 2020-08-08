enum CollectState { CONCERNED, STRANGE, SElF }

const CollectStateValues = {"CONCERNED": "已关注", "STRANGE": "未关注", "SElF": "自己"};

enum FollowState { CONCERNED, STRANGE, SElF }

const FollowStateValues = {"CONCERNED": "已关注", "STRANGE": "未关注", "SElF": "自己"};

enum VerificationCodeOperation { REGISTER, FORGET }

const VerificationCodeOperationValues = {"REGISTER": "注册账号", "FORGET": "忘记密码"};

enum Gender {
  MALE,
  FEMALE,
  UNKNOWN,
  INCONVENIENT,
}

const GenderValues = {
  "MALE": "男孩",
  "FEMALE": "女孩",
  "UNKNOWN": "未知",
  "INCONVENIENT": "不便透露"
};

enum PrivacyState { PUBLIC, PRIVATE }

const PrivacyStateValues = {"PUBLIC": "公开", "PRIVATE": "隐藏"};