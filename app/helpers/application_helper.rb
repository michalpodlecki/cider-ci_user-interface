#  Copyright (C) 2013, 2014, 2015 Dr. Thomas Schank  (DrTom@schank.ch, Thomas.Schank@algocon.ch)
#  Licensed under the terms of the GNU Affero General Public License v3.
#  See the LICENSE.txt file provided with this software.

module ApplicationHelper

  def render_summary_svgbox(view_params)
    capture(
      render partial: 'summary_svgbox', locals: view_params
    )
  end

  def icon_class_for_state(state)
    case state
    when 'executing', 'dispatching'
      'icon-executing'
    when 'failed'
      'icon-failed'
    when 'pending'
      'icon-pending'
    when 'passed'
      'icon-passed'
    end
  end

  def label_for_state(state)
    render 'label_for_state', state: state
  end

  def link_to_commit(commit)
    render partial: 'link_to_commit', locals: { commit: commit }
  end

  def form_group(label, opts = {}, &block)
    control_id = (opts[:control_id] || SecureRandom.uuid)
    render 'form_group', label: label,
                         control_id: control_id,
                         cols_label: (opts[:cols_label] || 3),
                         label_class: (opts[:label_class] || ''),
                         cols_control: (opts[:cols_control] || 5),
                         block_output: capture(opts.merge(control_id: control_id), &block)
  end

  def markdown(source)
    begin
      Kramdown::Document.new(source).to_html.html_safe
    rescue Exception => e
      Rails.logger.error Formatter.exception_to_log_s e
      'Markdown render error!'
    end
  end

  def render_executor_row(executor, &block)
    render 'executor_row', executor: executor, block_output: capture(&block)
  end

  def label_class_for_state(state)
    case state
    when 'failed'
      'label-failed'
    when 'passed'
      'label-passed'
    when 'pending'
      'label-pending'
    when 'executing', 'dispatched'
      'label-executing'
    else
      'label-default'
    end
  end

end
