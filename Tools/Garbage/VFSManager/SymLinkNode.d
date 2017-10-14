/**
 * Copyright (c) Rikarin and contributors. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

module VFSManager.SymLinkNode;

import VFSManager;


abstract class SymLinkNode : FSNode {
    this(DirectoryNode parent, FileAttributes fileAttributes) {
        m_attributes      = fileAttributes;
        m_attributes.Type = FileType.SymLink;

        super(parent);
    }
}