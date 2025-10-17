#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

# bats file_tags=mattermost
setup() {
    user_id=4ak3ax6gkf8cznkzsk3w9jp7zo
    team_divibib=47b4bd3qtb8ztpy9a64578h1go
    team_ekz=fthj1o37njdd3ptnd6fe9r3cty
    channel_spielwiese=stjt3yqjzf8o585e7z88xw3a7w
    post_id=n3ztukd9r78nuqzw56zxx8g91h
    SHARED_ENV="$BATS_FILE_TMPDIR/mattermost.env"
    bats_load_library bats-support
    bats_load_library bats-assert
    load $BASHLIB_HOME/loader
}

######################################################################################
# Mattermost Internal
######################################################################################

# bats test_tags=_mattermost_user
@test "_mattermost_user: should get current user id" {
    run --separate-stderr _mattermost_user
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output $user_id
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=_mattermost_team
@test "_mattermost_team: should get id for divibib" {
    run --separate-stderr _mattermost_team divibib
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output $team_divibib
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=_mattermost_team
@test "_mattermost_team: should get id for ekz" {
    run --separate-stderr _mattermost_team ekz
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output $team_ekz
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=_mattermost_channel
@test "_mattermost_channel: should get named channel" {
    run --separate-stderr _mattermost_channel $team_divibib Spielwiese
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output $channel_spielwiese
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=_mattermost_channel
@test "_mattermost_channel: fail for wrong channel name" {
    run --separate-stderr _mattermost_channel $team_divibib Quatsch
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output ""
    assert_failure
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=_mattermost_channel_bypost
@test "_mattermost_channel_bypost: for existing post" {
    run --separate-stderr _mattermost_channel_bypost $post_id
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output $channel_spielwiese
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=_mattermost_post
@test "_mattermost_post: should make new message" {
    run --separate-stderr _mattermost_post $channel_spielwiese "BATS Test"
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output -e '.+'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    echo "postid=$output" >>$SHARED_ENV
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: should post an attachment" {
    run --separate-stderr _mattermost_post $channel_spielwiese "" \
    '{ color: "#FF8000", title: "Test Alert", title_link: "http://grafana.service.cloud.dvb/", text: "This is the attachment text."}'
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output -e '.+'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    echo "postid=$output" >>$SHARED_ENV
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: should post two attachments" {
    run --separate-stderr _mattermost_post $channel_spielwiese "" \
    '[{ color: "#FF8000", title: "Test Alert", text: "This is the attachment text."},
    { color: "#00FF00", title: "System OK", text: "This is the attachment text."}]'
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output -e '.+'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    echo "postid=$output" >>$SHARED_ENV
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with image" {
    run --separate-stderr _mattermost_post $channel_spielwiese "" \
    '{ image_url: "https://img.icons8.com/?size=100&id=q7wteb2_yVxu&format=png&color=000000", text: "This is the attachment text."}'
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output -e '.+'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    echo "postid=$output" >>$SHARED_ENV
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with author" {
    run --separate-stderr _mattermost_post $channel_spielwiese "" \
    '{ color: "#FF8000", author_name: "Test BOT", author_icon: "https://img.icons8.com/?size=100&id=q7wteb2_yVxu&format=png&color=000000", author_link: "http://grafana.service.cloud.dvb/", title: "Test Alert", text: "This is the attachment text."}'
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output -e '.+'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    echo "postid=$output" >>$SHARED_ENV
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with thumb image" {
    run --separate-stderr _mattermost_post $channel_spielwiese "" \
    '{ color: "#FF8000", thumb_url: "https://img.icons8.com/?size=100&id=q7wteb2_yVxu&format=png&color=000000", title: "Test Alert", text: "This is the attachment text."}'
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output -e '.+'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    echo "postid=$output" >>$SHARED_ENV
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with fields" {
    run --separate-stderr _mattermost_post $channel_spielwiese "" \
    '{ color: "#FF8000", title: "Test Alert", text: "This is the attachment text.", "fields": [{"short":false, "title":"Long Field", "value":"Testing with a very long piece of text that will take up the whole width of the table. And then some more text to make it extra long." }, { "short":true, "title":"Column One", "value":"Testing" }, { "short":true, "title":"Column Two", "value":"Testing" }]}'
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output -e '.+'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    echo "postid=$output" >>$SHARED_ENV
}
# bats test_tags=_mattermost_post
@test "_mattermost_post: attachment with footer" {
    run --separate-stderr _mattermost_post $channel_spielwiese "" \
    '{ text: "This is the attachment text.", footer: "Made by Bats Test Suite", footer_icon: "https://img.icons8.com/?size=100&id=q7wteb2_yVxu&format=png&color=000000" }'
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output -e '.+'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
    echo "postid=$output" >>$SHARED_ENV
}

# bats test_tags=_mattermost_repost
@test "_mattermost_repost: answer to message" {
    source $SHARED_ENV
    run --separate-stderr _mattermost_repost $channel_spielwiese $postid "going on..."
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output -e '.+'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=_mattermost_reaction
@test "_mattermost_reaction: should add reaction" {
    source $SHARED_ENV
    run --separate-stderr _mattermost_reaction $postid white_check_mark
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output ''
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

# bats test_tags=_mattermost_find_channels
@test "_mattermost_find_channels: should get named channel" {
    run --separate-stderr _mattermost_find_channels Spielwiese
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output "$team_divibib/$channel_spielwiese "
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
# bats test_tags=_mattermost_find_channels
@test "_mattermost_find_channels: should get one channel for server" {
    skip
    server=media.host.office.dvb
    run --separate-stderr _mattermost_find_channels media.host.office.dvb
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output 'Status Produktiv'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}

######################################################################################
# Mattermost Chat
######################################################################################

# bats test_tags=mattermost_attachment
@test "mattermost_attachment: should make an attachment" {
    run --separate-stderr mattermost_attachment --color "#FF8000" --title "Grafana Alert" --text "This is the attachment text."
    [ -z "$stderr" ] || echo "$stderr" | sed 's/^/   /' >&3
    assert_output '{
  "color": "#FF8000",
  "title": "Grafana Alert",
  "text": "This is the attachment text."
}'
    assert_success
    echo $output # use --show-output-of-passing-tests to see it
}
