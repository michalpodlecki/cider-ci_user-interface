require 'spec_helper_feature'
require 'spec_helper_feature_shared'

feature 'Result', browser: :firefox do
  scenario 'From execution over task to trials' do
    sign_in_as 'normin'
    execution = Execution.reorder('created_at DESC').first
    execution.update_attributes! \
      result: execution.tasks.where('result IS NOT NULL').first.result
    visit workspace_execution_path(execution)
    expect(find('.result-summary')).to have_content '58.90%'
    click_on 'Result'
    expect(current_path).to match %r{/workspace/executions/[^/]+/result}
    expect(page).to have_content '58.90%'
    click_on 'Execution'
    find('select#tasks_select_condition').select('All')
    click_on('Filter')
    first('a', text: 'Create a result file').click
    click_on 'Result'
    expect(current_path).to match %r{/workspace/tasks/[^/]+/result}
    expect(page).to have_content '58.90%'
    click_on 'Task'
    click_on 'main'
    click_on 'Result'
    expect(current_path).to match %r{/workspace/trials/[^/]+/result}
    expect(page).to have_content '58.90%'
  end
end
