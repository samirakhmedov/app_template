# basic
cp secrets/secrets.env	apps/basic/android/fastlane/.env.default
cp secrets/dev.env	apps/basic/android/fastlane/.env.dev
cp secrets/prod.env	apps/basic/android/fastlane/.env.prod
cp secrets/dev.jks	apps/basic/android/keystore/
cp secrets/prod.jks	apps/basic/android/keystore/

cp secrets/secrets.env	apps/basic/ios/fastlane/.env.default
cp secrets/dev.env	apps/basic/ios/fastlane/.env.dev
cp secrets/prod.env	apps/basic/ios/fastlane/.env.prod

# debug
cp secrets/secrets.env	apps/debug/android/fastlane/.env.default
cp secrets/dev.env	apps/debug/android/fastlane/.env.dev
cp secrets/prod.env	apps/debug/android/fastlane/.env.prod
cp secrets/dev.jks	apps/debug/android/keystore/
cp secrets/prod.jks	apps/debug/android/keystore/

cp secrets/secrets.env	apps/debug/ios/fastlane/.env.default
cp secrets/dev.env	apps/debug/ios/fastlane/.env.dev
cp secrets/prod.env	apps/debug/ios/fastlane/.env.prod

# huawei (android only)
cp secrets/secrets.env	apps/huawei/android/fastlane/.env.default
cp secrets/dev.env	apps/huawei/android/fastlane/.env.dev
cp secrets/prod.env	apps/huawei/android/fastlane/.env.prod
cp secrets/huawei.jks	apps/huawei/android/keystore/

security import ./secrets/dev_account.p12 -P {password} -A