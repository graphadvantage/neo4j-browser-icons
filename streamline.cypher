
// raw map import

WITH
[
{name: 'image', code: '!'},
{name: 'user', code: '"'},
{name: 'edit', code: '#'},
{name: 'trash', code: '$'},
{name: 'settings-circle', code: '%'},
{name: 'zoom-in', code: '&'},
{name: 'zoom-out', code: "'"},
{name: 'upload', code: '('},
{name: 'download', code: ')'},
{name: 'keyhole-circle', code: '*'},
{name: 'link', code: '+'},
{name: 'unlink', code: ','},
{name: 'visible', code: '-'},
{name: 'hidden', code: '.'},
{name: 'envelope', code: '/'},
{name: 'data-warning', code: '0'},
{name: 'data-stop', code: '1'},
{name: 'data-lock', code: '2'},
{name: 'data-refresh', code: '3'},
{name: 'data-settings', code: '4'},
{name: 'data-write', code: '5'},
{name: 'data-subtract', code: '6'},
{name: 'data-add', code: '7'},
{name: 'disk-upload', code: '8'},
{name: 'disk-download', code: '9'},
{name: 'flowchart', code: ':'},
{name: 'heart-circle-reverse', code: '<'},
{name: 'folder', code: '='},
{name: 'chat-bubble', code: '>'},
{name: 'chevron-double-down', code: '?'},
{name: 'chevron-double-up', code: '@'},
{name: 'controls', code: 'A'},
{name: 'palette', code: 'B'},
{name: 'analytics', code: 'C'},
{name: 'chevron-circle-right', code: 'D'},
{name: 'chevron-circle-up', code: 'E'},
{name: 'chevron-circle-down', code: 'F'},
{name: 'chevron-left', code: 'G'},
{name: 'chevron-right', code: 'H'},
{name: 'close', code: 'I'},
{name: 'chevron-up', code: 'J'},
{name: 'chevron-down', code: 'K'},
{name: 'arrow-left', code: 'L'},
{name: 'arrow-right', code: 'M'},
{name: 'arrow-up', code: 'N'},
{name: 'expand', code: 'O'},
{name: 'cloud-download', code: 'P'},
{name: 'cloud-upload', code: 'Q'},
{name: 'data', code: 'R'},
{name: 'unlocked', code: 'S'},
{name: 'locked', code: 'T'},
{name: 'arrow-down', code: 'U'},
{name: 'triangle-down', code: 'V'},
{name: 'keyhole-reverse', code: 'W'},
{name: 'star-circle-reverse', code: 'X'},
{name: 'triangle-up', code: 'Y'},
{name: 'chevron-down-skip', code: 'Z'},
{name: 'subtract-circle', code: '['},
{name: 'chat-bubble-chatting', code: '\\'},
{name: 'add-circle', code: ']'},
{name: 'close-circle', code: '^'},
{name: 'home', code: '_'},
{name: 'location', code: '`'},
{name: 'star', code: 'a'},
{name: 'chat-bubble-text', code: 'b'},
{name: 'user-circle', code: 'c'},
{name: 'settings', code: 'd'},
{name: 'docs', code: 'e'},
{name: 'graph', code: 'f'},
{name: 'collapse', code: 'g'},
{name: 'pin', code: 'h'},
{name: 'heart', code: 'i'},
{name: 'heart-circle', code: 'j'},
{name: 'contact', code: 'k'},
{name: 'tiles', code: 'l'},
{name: 'cloud-close', code: 'm'},
{name: 'cloud-check', code: 'n'},
{name: 'cloud-refresh', code: 'o'},
{name: 'data-check', code: 'p'},
{name: 'data-close', code: 'q'},
{name: 'code', code: 'r'},
{name: 'star-circle', code: 's'},
{name: 'edit-circle-reverse', code: 't'},
{name: 'graph-cyclic', code: 'u'},
{name: 'chevron-circle-left', code: 'v'},
{name: 'play-circle', code: 'w'},
{name: 'cloud', code: 'x'},
{name: 'warning', code: 'y'},
{name: 'question-circle', code: 'z'},
{name: 'table', code: '{'},
{name: 'session', code: '|'},
{name: 'script', code: '}'},
{name: 'invoice', code: '~'}
] AS icons
FOREACH ( icon IN icons | CREATE (n:Icon {name: icon.name, code: icon.code}) SET n:{icon.name})
RETURN *;

// export CREATE
MATCH (n:Icon)
WITH n, (split(n.name,'-')) AS name
WITH n,
CASE
  WHEN size(name) = 1
  THEN upper(left(name[0],1))+right(name[0],size(name[0])-1)
  WHEN size(name) = 2
  THEN upper(left(name[0],1))+right(name[0],size(name[0])-1) + upper(left(name[1],1))+right(name[1],size(name[1])-1)
  ELSE upper(left(name[0],1))+right(name[0],size(name[0])-1) + upper(left(name[1],1))+right(name[1],size(name[1])-1) + upper(left(name[2],1))+right(name[2],size(name[2])-1)
  END AS lbl
RETURN 'CREATE (n:' + lbl + ':Icons {name: "' + n.name + '", code: "' + n.code + '"}) RETURN n;'

// export grass
MATCH (n:Icons)
WITH labels(n)[0] AS l0, labels(n)[1] AS l1, n.code AS code
WITH code, CASE l0 WHEN 'Icons' THEN l1 ELSE l0 END AS lbl
RETURN "node."+ lbl + " {color: #FFD86E; border-color: #EDBA39; text-color-internal: #604A0E; caption: '{name}'; diameter: 120px; icon-code: " + code + ";}"
