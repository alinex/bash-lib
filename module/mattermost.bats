#!/usr/bin/env bats

# bats file_tags=mattermost
setup_file() {
    skip "Skipping to not make so much noise in channel."
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
    if [ -z "$MATTERMOST_API" ] || [ -z "$MATTERMOST_TOKEN" ]; then
        skip "Because mattermost access is not set."
    fi
}
setup() {
    user_id=4ak3ax6gkf8cznkzsk3w9jp7zo
    team_divibib=47b4bd3qtb8ztpy9a64578h1go
    team_ekz=fthj1o37njdd3ptnd6fe9r3cty
    channel_spielwiese=stjt3yqjzf8o585e7z88xw3a7w
    post_id=n3ztukd9r78nuqzw56zxx8g91h
    # shellcheck disable=SC2154
    load "$BASHLIB_HOME/tests/bats-library-loader"
}

######################################################################################
# _mattermost_user
######################################################################################

# bats test_tags=_mattermost_user
@test "_mattermost_user: should get current user id" {
    run _mattermost_user
    assert_output "$user_id"
    assert_success
}

######################################################################################
# _mattermost_team
######################################################################################

# bats test_tags=_mattermost_team
@test "_mattermost_team: should get id for divibib" {
    run _mattermost_team divibib
    assert_output "$team_divibib"
    assert_success
}
# bats test_tags=_mattermost_team
@test "_mattermost_team: should get id for ekz" {
    run _mattermost_team ekz
    assert_output "$team_ekz"
    assert_success
}

######################################################################################
# _mattermost_channel
######################################################################################

# bats test_tags=_mattermost_channel
@test "_mattermost_channel: should get named channel" {
    run _mattermost_channel "$team_divibib" Spielwiese
    assert_output "$channel_spielwiese"
    assert_success
}
# bats test_tags=_mattermost_channel
@test "_mattermost_channel: fail for wrong channel name" {
    run _mattermost_channel "$team_divibib" Quatsch
    assert_failure
}

######################################################################################
# _mattermost_channel_bypost
######################################################################################

# bats test_tags=_mattermost_channel_bypost
@test "_mattermost_channel_bypost: for existing post" {
    run _mattermost_channel_bypost "$post_id"
    assert_output "$channel_spielwiese"
    assert_success
}

######################################################################################
# _mattermost_post
######################################################################################

# bats test_tags=_mattermost_post
@test "_mattermost_post: should make new message" {
    run _mattermost_post "$channel_spielwiese" "BATS Test"
    assert_output -e '.+'
    assert_success
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: should post an attachment" {
    run _mattermost_post "$channel_spielwiese" "" \
    '{ color: "#FF8000", title: "Test Alert", title_link: "http://grafana.service.cloud.dvb/", text: "This is the attachment text."}'
    assert_output -e '.+'
    assert_success
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: should post two attachments" {
    run _mattermost_post "$channel_spielwiese" "" \
    '[{ color: "#FF8000", title: "Test Alert", text: "This is the attachment text."},
    { color: "#00FF00", title: "System OK", text: "This is the attachment text."}]'
    assert_output -e '.+'
    assert_success
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with image" {
    run _mattermost_post "$channel_spielwiese" "" \
    '{ image_url: "https://img.icons8.com/?size=100&id=q7wteb2_yVxu&format=png&color=000000", text: "This is the attachment text."}'
    assert_output -e '.+'
    assert_success
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with author" {
    run _mattermost_post "$channel_spielwiese" "" \
    '{ color: "#FF8000", author_name: "Test BOT", author_icon: "https://img.icons8.com/?size=100&id=q7wteb2_yVxu&format=png&color=000000", author_link: "http://grafana.service.cloud.dvb/", title: "Test Alert", text: "This is the attachment text."}'
    assert_output -e '.+'
    assert_success
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with thumb image" {
    run _mattermost_post "$channel_spielwiese" "" \
    '{ color: "#FF8000", thumb_url: "https://img.icons8.com/?size=100&id=q7wteb2_yVxu&format=png&color=000000", title: "Test Alert", text: "This is the attachment text."}'
    assert_output -e '.+'
    assert_success
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with fields" {
    run _mattermost_post "$channel_spielwiese" "" \
    '{ color: "#FF8000", title: "Test Alert", text: "This is the attachment text.", "fields": [{"short":false, "title":"Long Field", "value":"Testing with a very long piece of text that will take up the whole width of the table. And then some more text to make it extra long." }, { "short":true, "title":"Column One", "value":"Testing" }, { "short":true, "title":"Column Two", "value":"Testing" }]}'
    assert_output -e '.+'
    assert_success
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with footer" {
    run _mattermost_post "$channel_spielwiese" "" \
    '{ text: "This is the attachment text.", footer: "Made by Bats Test Suite", footer_icon: "https://img.icons8.com/?size=100&id=q7wteb2_yVxu&format=png&color=000000" }'
    assert_output -e '.+'
    assert_success
}

######################################################################################
# _mattermost_delete
######################################################################################

# bats test_tags=_mattermost_delete
@test "_mattermost_delete: should make new message" {
    pid="$(_mattermost_post "$channel_spielwiese" "BATS DELETE Test")"
    run _mattermost_delete "${pid#*/}"
    assert_success
}

######################################################################################
# _mattermost_repost
######################################################################################

# bats test_tags=_mattermost_repost
@test "_mattermost_repost: answer to message" {
    pid="$(_mattermost_post "$channel_spielwiese" "BATS DELETE Test")"
    # shellcheck disable=SC2154
    run _mattermost_repost "$channel_spielwiese" "${pid#*/}" "going on..."
    assert_output -e '.+'
    assert_success
}

######################################################################################
# _mattermost_reaction
######################################################################################

# bats test_tags=_mattermost_reaction
@test "_mattermost_reaction: should add reaction" {
    pid="$(_mattermost_post "$channel_spielwiese" "BATS DELETE Test")"
    run _mattermost_reaction "${pid#*/}" white_check_mark
    assert_output ''
    assert_success
}

######################################################################################
# _mattermost_find_channels
######################################################################################

# bats test_tags=_mattermost_find_channels
@test "_mattermost_find_channels: should get named channel" {
    run _mattermost_find_channels Spielwiese
    assert_output -p "$team_divibib/$channel_spielwiese "
    assert_success
}

######################################################################################
# mattermost_attachment
######################################################################################

# bats test_tags=mattermost_attachment
@test "mattermost_attachment: should make an attachment" {
    run mattermost_attachment --color "#FF8000" --title "Grafana Alert" --text "This is the attachment text."
    assert_output '{
  "color": "#FF8000",
  "title": "Grafana Alert",
  "text": "This is the attachment text."
}'
    assert_success
}

######################################################################################
# mattermost
######################################################################################

# bats test_tags=mattermost
@test "mattermost: should make new message" {
    run mattermost Spielwiese "BATS Test"
    assert_success
}

######################################################################################
# mattermost_reaction
######################################################################################

# bats test_tags=mattermost_reaction
@test "mattermost_reaction: should add a smiley" {
    mattermost Spielwiese "BATS Test"
    run mattermost_reaction white_check_mark
    assert_success
}

######################################################################################
# mattermost_repost
######################################################################################

# bats test_tags=mattermost_repost
@test "mattermost_repost: should add text" {
    mattermost Spielwiese "BATS Test"
    run mattermost_repost "will work on it"
    assert_success
}
