{
/*
	 // Place your snippets for JavaScript here. Each snippet is defined under a snippet name and has a prefix, body and
	 // description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
	 // $1, $2 for tab stops, ${id} and ${id:label} and ${1:label} for variables. Variables with the same id are connected.
	 // Example:
	 "Print to console": {
		"prefix": "log",
		"body": [
			"console.log('$1');",
			"$2"
		],
		"description": "Log output to console"
	}
*/
  "Console log": {
    "prefix": "log",
    "body": [
      "console.log($1)",
      "$2"
    ]
  },
  "Console group": {
    "prefix": "group",
    "body": [
      "console.group('${1}')",
      "console.log(${2})",
      "console.groupEnd()"
    ]
  },
  "Console warn": {
    "prefix": "warn",
    "body": [
      "console.warn('$1')",
      "$2"
    ]
  },
  "Describe": {
    "prefix": "des",
    "body": [
      "describe('$1', function () {",
      "  $2",
      "})"
    ]
  },
  "It": {
    "prefix": "it",
    "body": [
      "it('$1', function () {",
      "  $2",
      "})"
    ]
  },
  "It Should": {
    "prefix": "sh",
    "body": [
      "it('Should $1.', function () {",
      "  $2",
      "})"
    ]
  }
}
