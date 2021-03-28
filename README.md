# GIG (GitHub Image Grep)

Command line tool using the public GitHub API to download and save avatar images from repository owners matching the
provided search criteria.

## Installation

This is just a sample, so the gem is not published. If you want to use it, add this line to your application's Gemfile:

```ruby
gem 'gig', git: 'git@github.com:pippokairos/gig.git'
```

And then execute:

```
$ bundle install
```

## Usage

Execute `gig.rb` passing the search query. You can use all the [allowed qualifiers described in the GitHub API documentation](https://docs.github.com/en/github/searching-for-information-on-github/searching-for-repositories).

```
$ ruby bin/gig.rb topic:banana topic:fun
```

<table>

<thead>
<tr>
<th>Option</th>
<th>Description</th>
</tr>
</thead>

<tbody>
<tr>
<td>`-v, --verbose`</td>
<td>Get verbose logging</td>
</tr>

<tr> 
<td>`cd [-options] [path/to/directory]`</td>
<td>Changes the current working directory to the specified directory</td>
</tr>

<tr>
<td>`-f, --images-folder`</td>
<td>Set custom folder for the images</td>
</tr>

<tr>
<td>`-o, --output-file`</td>
<td>Set custom output file instead of STDOUT for logging</td>
</tr>

<tr>
<td>`--github-access-token`</td>
<td>Set your GitHub access token to perform an authorized call (useful to avoid GitHub API rate limit)</td>
</tr>

<tr>
<td>`--per-page`</td>
<td>Define pagination size</td>
</tr>

<tr>
<td>`--page`</td>
<td>Request specific page</td>
</tr>
</tbody>

</table>

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
